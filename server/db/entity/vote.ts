import { Entity, Column, BaseEntity, JoinColumn, OneToMany, PrimaryColumn, ManyToOne } from "typeorm"
import { ObjectType, Field } from "type-graphql"
import { Poll } from "./poll"

@Entity()
@ObjectType()
export class Vote extends BaseEntity {
  @PrimaryColumn()
  @Field()
  iconame!: string

  @PrimaryColumn()
  @Field()
  idvoter!: string

  @Column()
  @Field()
  trvoter!: string

  @Column()
  @Field()
  pick!: boolean

  @ManyToOne(type => Poll, poll => poll.votes, { onDelete: "CASCADE"})
  @JoinColumn({ name: "iconame" })
  poll!: Poll
}