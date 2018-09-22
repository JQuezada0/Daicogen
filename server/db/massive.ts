import * as massive from "massive"

export default massive({
  host: 'database',
  port: 5432,
  database: 'postgres',
  user: 'postgres',
  password: ''
})