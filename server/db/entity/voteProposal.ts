import { Entity, Column, BaseEntity, JoinColumn, OneToMany, PrimaryColumn, ManyToOne } from "typeorm"
import { ObjectType, Field } from "type-graphql"
import { Poll } from "./poll"

@Entity()
@ObjectType()
export class VoteProposal extends BaseEntity {

  @PrimaryColumn()
  @Field()
  iconame!: string

  @PrimaryColumn()
  @Field()
  from!: string

  @Column()
  @Field()
  to!: string

  @Column()
  @Field()
  pick!: boolean

  @ManyToOne(type => Poll, poll => poll.voteProposals, { onDelete: "CASCADE" })
  @JoinColumn({ name: "iconame" })
  poll!: Poll
}