# 베이스 이미지
FROM adoptopenjdk/openjdk11
# 작성자 라벨 생성
LABEL maintainer "shqkel<shqkel1863@gmail.com>"
# 버전 라벨 생성
LABEL version "1.0.0"
# build시에만 사용할 변수 선언
ARG JAR_FILE_PATH=target/*.jar
# root 디렉토리에 app.jar복사
COPY ${JAR_FILE_PATH} app.jar
# 컨테이너 실행 시 app.jar 자동 실행
ENTRYPOINT ["java", "-jar", "/app.jar"]