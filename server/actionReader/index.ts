import { NodeosActionReader } from "demux-eos"
import { MassiveActionHandler } from "../actionHandler/index"
import { BaseActionWatcher } from "demux"
import updaters from "./updaters"
import Massive from "../db/massive"
import connection from "../db/connection"

export default async () => {
  await connection
  const massive = await Massive

  const lastKnownBlock = await massive._index_state.findOne({}, {
    order: [{field: 'block_number', direction: 'desc'}]
  })

  const lastKnownBlockNumber = lastKnownBlock && lastKnownBlock.block_number || 0

  console.log("LAST KNOW BLOCK", lastKnownBlockNumber)

  const actionReader = new NodeosActionReader(
    "http://eosio:8888",
    lastKnownBlockNumber,
  )
  
  const actionHandler = new MassiveActionHandler(
    updaters,
    [],
    massive,
  )
  
  const actionWatcher = new BaseActionWatcher(
    actionReader,
    actionHandler,
    100,
  )

  await actionWatcher.watch()
}