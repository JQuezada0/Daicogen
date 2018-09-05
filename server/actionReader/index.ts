import { NodeosActionReader } from "demux-eos"
import { MassiveActionHandler } from "../actionHandler/index"
import { BaseActionWatcher } from "demux"
import updaters from "./updaters"
import effects from "./effects"
import Massive from "../db/massive"
import connection from "../db/connection"

export default async () => {

  await connection
  const massive = await Massive

  const actionReader = new NodeosActionReader(
    "eosio::8888", // Locally hosted node needed for reasonable indexing speed
    0, // First actions relevant to this dapp happen at this block
  )

  const actionHandler = new MassiveActionHandler(
    updaters,
    effects,
    massive,
  )
}