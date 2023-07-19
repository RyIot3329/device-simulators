const express = require("express");
const app = express();
const port = 3000;

app.get("/api/v2/sim/ping", (req, res) => {
  const data = {
    timestamp: Date.now(),
    message: "pong",
  };
  res.send(JSON.stringify(data));
});

app.get("/api/v2/sim/spacetemp", (req, res) => {
  const data = {
    timestamp: Date.now(),
    message: randomNumber(65, 85),
  };
  res.send(JSON.stringify(data));
});

app.get("/api/v2/sim/co2", (req, res) => {
  const data = {
    timestamp: Date.now(),
    message: randomNumber(0, 500),
  };
  res.send(JSON.stringify(data));
});

app.get("/api/v2/sim/spacehumidity", (req, res) => {
  const data = {
    timestamp: Date.now(),
    message: randomNumber(30, 75),
  };
  res.send(JSON.stringify(data));
});

app.get("/api/v2/sim/fanstatus", (req, res) => {
  const data = {
    timestamp: Date.now(),
    message: parseInt(randomNumber(0, 1)),
  };
  res.send(JSON.stringify(data));
});

app.get("/api/v2/sim/mode", (req, res) => {
  const data = {
    timestamp: Date.now(),
    message: parseInt(randomNumber(0, 4)),
  };
  res.send(JSON.stringify(data));
});

app.get("/api/v2/sim/datemp", (req, res) => {
  const data = {
    timestamp: Date.now(),
    message: randomNumber(48, 65),
  };
  res.send(JSON.stringify(data));
});

app.get("/api/v2/sim/ratemp", (req, res) => {
  const data = {
    timestamp: Date.now(),
    message: randomNumber(68, 81),
  };
  res.send(JSON.stringify(data));
});

app.get("/api/v2/sim/coolingspt", (req, res) => {
  const data = {
    timestamp: Date.now(),
    message: 72,
  };
  res.send(JSON.stringify(data));
});

app.get("/api/v2/sim/heatingspt", (req, res) => {
  const data = {
    timestamp: Date.now(),
    message: 68,
  };
  res.send(JSON.stringify(data));
});

app.listen(port, () => {
  console.log(`REST thermostat simulator listening on port ${port}`);
});

function randomNumber(min, max) {
  let intValue = Math.random() * (max - min) + min;
  return parseFloat(intValue);
}
