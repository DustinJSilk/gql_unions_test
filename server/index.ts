import {
  mockSchema,
  createMockServer,
  startMockServer,
} from "fast-graphql-mock";

const schema = mockSchema(__dirname + "/schema.graphql");

const server = createMockServer(schema);

startMockServer(server, 3000);
