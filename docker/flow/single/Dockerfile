FROM node:12-alpine

WORKDIR /app

COPY package.json .
COPY yarn.lock .

RUN yarn

COPY . .

RUN npm run build

FROM nginx

EXPOSE 80

# Use unnamed steps to work around stupid Elastic Beanstalk bug.
COPY --from=0 /app/build /usr/share/nginx/html