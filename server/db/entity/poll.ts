import { Entity, Column, BaseEntity, OneToOne, JoinColumn, ManyToOne, PrimaryColumn, RelationId, OneToMany } from "typeorm"
import { ObjectType, Field } from "type-graphql"
import { Project } from "./project"
import { Vote } from "./vote"
import { VoteProposal } from "./voteProposal"

enum PollKind {
  FundsPerCycle = "FundsPerCycle"
}

@Entity()
@ObjectType()
export class Poll extends BaseEntity {
  @PrimaryColumn()
  @RelationId((poll: Poll) => poll.project)
  icocreator!: string

  @Column()
  @Field()
  proposal!: PollKind

  @Column()
  @Field()
  yesvotes!: number

  @Column()
  @Field()
  novotes!: number

  @ManyToOne(type => Project, project => project.polls, { onDelete: "CASCADE"})
  @JoinColumn({ name: "icocreator" })
  project!: Project

  @OneToMany(type => Vote, vote => vote.poll, { eager: true, onDelete: "CASCADE" })
  votes!: Vote[] 

  @OneToMany(type => VoteProposal, voteProposal => voteProposal.poll, { eager: true, onDelete: "CASCADE" })
  voteProposals!: VoteProposal[]
}