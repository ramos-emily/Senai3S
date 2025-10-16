#include <WiFi.h>
#include <WebServer.h>
#include <FS.h>
#include <SPIFFS.h>
#include <time.h>
#include <sys/time.h>
#include <Preferences.h>
#include <ArduinoJson.h>
#include <DHT.h>

// ---------- CONFIGURAÇÃO DO ACCESS POINT ----------
const char* ssid = "ESP32-SENAI-1";
const char* password = "12345678";

// ---------- SENSOR DHT ----------
#define DHTPIN 14
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);

// ---------- Arquivo CSV / WebServer / Preferences ----------
#define CSV_FILE "/medicoes.csv"
WebServer server(80);
Preferences preferences;

// ---------- Variáveis persistentes / de última leitura ----------
int maxRegistrosConfiguravel = 500;  // padrão se não configurado

String ultimaDataHora = "N/A";
float ultimaTemperatura = -1.0;
float ultimaUmidade = -1.0;

// ---------- Função para configurar horário com base na data/hora de compilação ----------
void setLocalTimeFromBuild() {
  struct tm tm_build = {0};
  strptime(__DATE__ " " __TIME__, "%b %d %Y %H:%M:%S", &tm_build);
  time_t t = mktime(&tm_build);
  struct timeval now = { .tv_sec = t };
  settimeofday(&now, NULL);
}

// ---------- Funções de manipulação de CSV no SPIFFS ----------
int contarLinhas() {
  File file = SPIFFS.open(CSV_FILE, FILE_READ);
  if (!file) return 0;
  int linhas = 0;
  while (file.available()) {
    file.readStringUntil('\n');
    linhas++;
  }
  file.close();
  return linhas;
}

void removePrimeiraLinha() {
  File file = SPIFFS.open(CSV_FILE, FILE_READ);
  if (!file) return;
  File tempFile = SPIFFS.open("/temp.csv", FILE_WRITE);
  if (!tempFile) {
    file.close();
    return;
  }
  bool primeira = true;
  while (file.available()) {
    String line = file.readStringUntil('\n');
    if (primeira) {
      primeira = false;
      continue;
    }
    tempFile.println(line);
  }
  file.close();
  tempFile.close();
  SPIFFS.remove(CSV_FILE);
  SPIFFS.rename("/temp.csv", CSV_FILE);
}

void appendToCSVAndUpdateLast(const String &dataHora, float temp, float umid) {
  int linhas = contarLinhas();
  if (linhas >= maxRegistrosConfiguravel) {
    Serial.println("Arquivo cheio. Removendo a linha mais antiga...");
    removePrimeiraLinha();
  }
  File file = SPIFFS.open(CSV_FILE, FILE_APPEND);
  if (!file) {
    Serial.println("Erro ao abrir arquivo para escrita.");
    return;
  }
  String line = dataHora + "," + String(temp, 2) + "," + String(umid, 2);
  file.println(line);
  file.close();

  // Atualiza memória
  ultimaDataHora = dataHora;
  ultimaTemperatura = temp;
  ultimaUmidade = umid;
  Serial.println("Registro adicionado: " + line);
}

void carregarUltimaDoCSV() {
  File file = SPIFFS.open(CSV_FILE, FILE_READ);
  if (!file) {
    ultimaDataHora = "N/A";
    ultimaTemperatura = -1.0;
    ultimaUmidade = -1.0;
    return;
  }
  String lastLine = "";
  while (file.available()) {
    String line = file.readStringUntil('\n');
    line.trim();
    if (line.length() > 0) lastLine = line;
  }
  file.close();
  if (lastLine.length() > 0) {
    int sep1 = lastLine.indexOf(',');
    int sep2 = lastLine.lastIndexOf(',');
    if (sep1 > 0 && sep2 > sep1) {
      ultimaDataHora = lastLine.substring(0, sep1);
      ultimaTemperatura = lastLine.substring(sep1 + 1, sep2).toFloat();
      ultimaUmidade = lastLine.substring(sep2 + 1).toFloat();
    }
  }
}

// ---------- Helpers de data/hora ----------
String getNowString() {
  struct tm timeinfo;
  if (!getLocalTime(&timeinfo)) {
    return "N/A";
  }
  char buf[32];
  strftime(buf, sizeof(buf), "%d/%m/%Y %H:%M:%S", &timeinfo);
  return String(buf);
}

// ---------- Preferences (armazenamento configurável) ----------
void carregarConfiguracoes() {
  preferences.begin("config", true);
  maxRegistrosConfiguravel = preferences.getInt("max_reg", 500);
  preferences.end();
  Serial.printf("Config carregada: max_reg=%d\n", maxRegistrosConfiguravel);
}

void salvarMaxRegistros(int valor) {
  preferences.begin("config", false);
  preferences.putInt("max_reg", valor);
  preferences.end();
}

// ---------- Handlers de rotas Web / API ----------
void handleRoot() {
  String html = "<!DOCTYPE html><html><head><meta charset='UTF-8'>";
  html += "<meta http-equiv='refresh' content='5'>";
  html += "<title>Histórico de Medições</title></head><body>";
  html += "<h1>Histórico de Medições (Máx " + String(maxRegistrosConfiguravel) + ")</h1>";
  html += "<a href='/download'>📥 Baixar CSV</a><br><br>";
  html += "<a href='/api/ultima'>API: Última Leitura</a> | ";
  html += "<a href='/api/todas'>API: Todas Leituras</a> | ";
  html += "<a href='/api/ler'>API: Ler Agora</a> | ";
  html += "<a href='/api/config/max_linhas'>API: Configurar Máx de Linhas (POST)</a><br><br>";
  html += "<table border='1'><tr><th>Data/Hora</th><th>Temperatura (°C)</th><th>Umidade (%)</th></tr>";
  File file = SPIFFS.open(CSV_FILE, FILE_READ);
  if (file) {
    while (file.available()) {
      String line = file.readStringUntil('\n');
      line.trim();
      if (line.length() == 0) continue;
      int sep1 = line.indexOf(',');
      int sep2 = line.lastIndexOf(',');
      if (sep1 > 0 && sep2 > sep1) {
        String dataHora = line.substring(0, sep1);
        String temp = line.substring(sep1 + 1, sep2);
        String umid = line.substring(sep2 + 1);
        html += "<tr><td>" + dataHora + "</td><td>" + temp + "</td><td>" + umid + "</td></tr>";
      }
    }
    file.close();
  } else {
    html += "<tr><td colspan='3'>Nenhum registro encontrado</td></tr>";
  }
  html += "</table></body></html>";
  server.send(200, "text/html; charset=UTF-8", html);
}

void handleDownload() {
  File file = SPIFFS.open(CSV_FILE, FILE_READ);
  if (!file) {
    server.send(404, "text/plain", "Arquivo não encontrado");
    return;
  }
  server.sendHeader("Content-Type", "text/csv");
  server.sendHeader("Content-Disposition", "attachment; filename=\"medicoes.csv\"");
  server.streamFile(file, "text/csv");
  file.close();
}

void apiUltima() {
  String json = "{";
  json += "\"dataHora\":\"" + ultimaDataHora + "\",";
  json += "\"temperatura_c\":" + String(ultimaTemperatura, 2) + ",";
  json += "\"umidade_pct\":" + String(ultimaUmidade, 2);
  json += "}";
  server.send(200, "application/json", json);
}

void apiTodas() {
  File file = SPIFFS.open(CSV_FILE, FILE_READ);
  if (!file) {
    server.send(200, "application/json", "[]");
    return;
  }
  String json = "[";
  bool first = true;
  while (file.available()) {
    String line = file.readStringUntil('\n');
    line.trim();
    if (line.length() == 0) continue;
    int sep1 = line.indexOf(',');
    int sep2 = line.lastIndexOf(',');
    if (sep1 <= 0 || sep2 <= sep1) continue;
    String dataHora = line.substring(0, sep1);
    String temp = line.substring(sep1 + 1, sep2);
    String umid = line.substring(sep2 + 1);
    if (!first) json += ",";
    json += "{\"dataHora\":\"" + dataHora + "\",\"temperatura_c\":" + temp + ",\"umidade_pct\":" + umid + "}";
    first = false;
  }
  file.close();
  json += "]";
  server.send(200, "application/json", json);
}

void apiLer() {
  float temp = dht.readTemperature();
  float umid = dht.readHumidity();
  String dataHora = getNowString();
  appendToCSVAndUpdateLast(dataHora, temp, umid);
  String json = "{";
  json += "\"dataHora\":\"" + dataHora + "\",";
  json += "\"temperatura_c\":" + String(temp, 2) + ",";
  json += "\"umidade_pct\":" + String(umid, 2);
  json += "}";
  server.send(200, "application/json", json);
}

void apiConfigMaxLinhas() {
  if (!server.hasArg("plain")) {
    server.send(400, "application/json", "{\"error\":\"Corpo JSON esperado\"}");
    return;
  }
  String body = server.arg("plain");
  StaticJsonDocument<200> doc;
  if (deserializeJson(doc, body)) {
    server.send(400, "application/json", "{\"error\":\"JSON inválido\"}");
    return;
  }
  if (!doc.containsKey("max_linhas")) {
    server.send(400, "application/json", "{\"error\":\"Campo 'max_linhas' ausente\"}");
    return;
  }
  int novoMax = doc["max_linhas"].as<int>();
  if (novoMax < 10) novoMax = 10;
  if (novoMax > 10000) novoMax = 10000;
  maxRegistrosConfiguravel = novoMax;
  salvarMaxRegistros(maxRegistrosConfiguravel);
  String resp = "{\"status\":\"ok\",\"max_linhas\":" + String(maxRegistrosConfiguravel) + "}";
  server.send(200, "application/json", resp);
}

// ---------- Setup / Loop ----------
void setup() {
  Serial.begin(115200);
  delay(1000);

  Serial.println("\nInicializando SPIFFS...");
  if (!SPIFFS.begin(true)) {
    Serial.println("Erro ao montar SPIFFS");
    // Se SPIFFS falhar, ainda assim podemos tentar seguir, mas TUDO que depende de arquivos vai falhar
  } else {
    Serial.println("SPIFFS montado com sucesso");
  }

  dht.begin();

  carregarConfiguracoes();

  // Se o arquivo não existe ainda, criar
  if (!SPIFFS.exists(CSV_FILE)) {
    File f = SPIFFS.open(CSV_FILE, FILE_WRITE);
    if (f) {
      f.close();
      Serial.println("Arquivo CSV criado");
    }
  }

  // Inicia o Access Point
  WiFi.softAP(ssid, password);
  IPAddress IP = WiFi.softAPIP();
  Serial.print("Access Point iniciado. IP: ");
  Serial.println(IP);

  setLocalTimeFromBuild();
  carregarUltimaDoCSV();

  // Rotas HTTP e APIs
  server.on("/", handleRoot);
  server.on("/download", handleDownload);
  server.on("/api/ultima", apiUltima);
  server.on("/api/todas", apiTodas);
  server.on("/api/ler", apiLer);
  server.on("/api/config/max_linhas", HTTP_POST, apiConfigMaxLinhas);

  server.begin();
  Serial.println("Servidor HTTP iniciado.");
}

void loop() {
  server.handleClient();

  float temp = dht.readTemperature();
  float umid = dht.readHumidity();
  String dataHora = getNowString();
  appendToCSVAndUpdateLast(dataHora, temp, umid);

  delay(5000);
}
