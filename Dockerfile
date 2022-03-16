FROM keymetrics/pm2:latest-alpine

WORKDIR /usr/app

# Bundle APP files
#COPY src src/
COPY package.json .
COPY pm2.json .

# Install app dependencies
ENV NPM_CONFIG_LOGLEVEL warn
RUN npm install --production
RUN pm2 install pm2-server-monit
RUN pm2 status

ENV PM2_PUBLIC_KEY q8bhxcwayzr0whh
ENV PM2_SECRET_KEY n6l61u0471lz38o

# Show current folder structure in logs
RUN ls -al -R
COPY . .

CMD [ "pm2-runtime", "start", "pm2.json" ]