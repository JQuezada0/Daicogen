const updateTransferData = (state: any, payload: any, blockInfo: any, context: any) => {
  console.dir(state)
  console.dir(payload)
}

const updaters = [
  {
    actionType: "hello::insert",
    updater: updateTransferData,
  },
]

export default updaters