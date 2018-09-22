import { Entity, Column, BaseEntity, JoinColumn, OneToMany, PrimaryColumn } from "typeorm"
import { ObjectType, Field } from "type-graphql"
import { Poll } from "./poll"

@Entity()
@ObjectType()
export class Vote extends BaseEntity {
  @PrimaryColumn()
  @Field()
  voter!: string // account name

  @Column()
  @Field()
  confirmed!: boolean

  @OneToMany(type => Poll, poll => poll.votes)
  @JoinColumn()
  poll!: Poll
}