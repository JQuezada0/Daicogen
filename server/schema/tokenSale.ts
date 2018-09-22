import { Resolver, Query, FieldResolver, Root } from "type-graphql"
import { TokenSale } from "../db/entity/tokenSale"

@Resolver(TokenSale)
export class TokenSaleResolver {
  @FieldResolver()
  name(@Root() tokenSale: TokenSale) {
    return tokenSale.name
  }

  @FieldResolver()
  symbol(@Root() tokenSale: TokenSale) {
    return tokenSale.symbol
  }

  @FieldResolver()
  supply(@Root() tokenSale: TokenSale) {
    return tokenSale.supply
  }

  @FieldResolver()
  allocation(@Root() tokenSale: TokenSale) {
    return tokenSale.allocation
  }

  @FieldResolver()
  value(@Root() tokenSale: TokenSale) {
    return tokenSale.value
  }

  @FieldResolver()
  softcap(@Root() tokenSale: TokenSale) {
    return tokenSale.softcap
  }

  @FieldResolver()
  hardcap(@Root() tokenSale: TokenSale) {
    return tokenSale.hardcap
  }

  @FieldResolver()
  startDate(@Root() tokenSale: TokenSale) {
    return tokenSale.startDate
  }

  @FieldResolver()
  endDate(@Root() tokenSale: TokenSale) {
    return tokenSale.endDate
  }
}