FROM node:18 as build-stage

WORKDIR /usr/src/app

COPY package* ./

RUN npm ci

COPY . .

RUN npm run swizzle docusaurus-lunr-search SearchBar -- --eject --danger

RUN npm run build

FROM node:alpine

ENV PORT 80

RUN npm install -g serve

COPY --from=build-stage /usr/src/app/build /usr/src/html

CMD serve -l $PORT /usr/src/html

# ADDING A COMMENT TO TEST WATCHTOWER
