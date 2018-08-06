kill $(< ./logs/server.pid)

cat ./logs/server.pid | xargs kill -9

kill -9 $ALTITUDE_PID || true

& env["ALTITUDE_PID"]=$!