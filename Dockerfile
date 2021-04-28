ARG NODE_VER=16-alpine

FROM node:$NODE_VER AS install

WORKDIR /SERVICE_NAME

COPY ./.yarn /SERVICE_NAME/.yarn
COPY ./package.json ./yarn.lock ./.yarnrc.yml /SERVICE_NAME/

RUN yarn workspaces focus --all --production

FROM install AS build

# Install dev deps too
RUN yarn install --immutable

COPY . /SERVICE_NAME/

# Build code and remove dev deps
RUN yarn build && rm -rfv .yarn .pnp*

FROM node:$NODE_VER AS production

# Do not run service as root
USER node

WORKDIR /SERVICE_NAME

COPY --from=install /SERVICE_NAME/ /SERVICE_NAME/
COPY --from=build /SERVICE_NAME/ /SERVICE_NAME/

ENTRYPOINT ["yarn", "run"]
CMD ["start"]
