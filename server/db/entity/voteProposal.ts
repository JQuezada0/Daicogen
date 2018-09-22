import { Entity, Column, BaseEntity, JoinColumn, OneToMany, PrimaryColumn } from "typeorm"
import { ObjectType, Field } from "type-graphql"
import { Poll } from "./poll"

@Entity()
@ObjectType()
export class VoteProposal extends BaseEntity {
  @PrimaryColumn()
  @Field()
  idVoter!: string // id account name

  @PrimaryColumn()
  @Field()
  delegatedVoter!: string // account_name

  @Column()
  @Field()
  choice!: boolean 

  @Column()
  @Field()
  voteCompleted!: boolean

  @OneToMany(type => Poll, poll => poll.votes)
  @JoinColumn()
  poll!: Poll
}