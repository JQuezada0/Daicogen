const updateFoo = (state: any, payload: any, blockInfo: any, context: any) => {
}

const updaters = [
  {
    actionType: "foo::action",
    updater: updateFoo,
  },
]

export default updaters
