import "reflect-metadata"
import { createConnection } from "typeorm"

export default createConnection(require("../ormconfig.json"))