const logUpdate = (state: any, payload: any, blockInfo: any, context: any) => {
  console.info("State updated:\n", JSON.stringify(state, null, 2))
}

const effects = [
  {
    actionType: "hello::insert",
    effect: logUpdate,
  },
]

export default effects