const logUpdate = (state: any, payload: any, blockInfo: any, context: any) => {
  console.info("State updated:")
  console.dir(state)
  console.dir(payload)
}

const effects = [
  {
    actionType: "foo::action",
    effect: logUpdate,
  },
]

export default effects