#!/bin/bash
PORT=8080
REPO="https://github.com/100-hours-a-week/5-yeosa-ongi-be.git"
PROJECT_NAME="5-yeosa-ongi-be"
APP_DIR="/home/ubuntu/$PROJECT_NAME"
JAR_PATH="$APP_DIR/build/libs/5-yeosa-ongi-be-0.0.1-SNAPSHOT.jar"
YML_PATH="$APP_DIR/src/main/resources/application.yml"

# 1. 프로젝트 없으면 clone
if [ ! -d "$APP_DIR" ]; then
  echo "$PROJECT_NAME not found. Cloning..."
  git clone $REPO $APP_DIR
else
  echo "$PROJECT_NAME already exists."
fi

cd $APP_DIR

# 2. application.yml 복사
mkdir -p $(dirname "$YML_PATH")
cat <<EOF > "$YML_PATH"
$application_yml
EOF

# 3. 프로젝트 빌드
chmod +x ./gradlew
./gradlew clean build -x test

# 4. 기존 프로세스 종료
PID=$(lsof -t -i:$PORT)
if [ -n "$PID" ]; then
  echo "Port $PORT is used by PID $PID. Killing..."
  kill -9 $PID
  echo "Killed process $PID."
else
  echo "Port $PORT is free."
fi

# 5. 앱 실행
nohup java -jar $JAR_PATH > /home/ubuntu/ongi-be.log 2>&1 &
echo "Application started on port $PORT."
