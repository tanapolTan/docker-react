FROM node:alpine as builder 
# builder is a variable name

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#ถึงตอนนี้จะมี /app/build ท่ีี่เราจะเอาไปใช้ใน nginx

FROM nginx as prod-web
COPY --from=builder /app/build /usr/share/nginx/html
# copy file จาก builder image ที่ folder /app/build ไปที่ nginx image folder /usr/share/nginx/html

#หลังจาก run file นี้จบให้ docker run -p 8080:80 <image name> ขึ้นมาก็เป็นอันเสร็จ
