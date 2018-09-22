import { Entity, Column, BaseEntity, OneToOne, JoinColumn, PrimaryGeneratedColumn, ManyToOne } from "typeorm"
import { ObjectType, Field } from "type-graphql"
import { Project } from "./project"
import { Vote } from "./vote"

enum PollKind {
  FundsPerCycle = "FundPerCycle"
}

@Entity()
@ObjectType()
export class Poll extends BaseEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column()
  @Field()
  kind!: PollKind;

  @Column()
  @Field()
  pollPassed!: boolean

  @Column()
  @Field()
  pollFinalized!: boolean

  @OneToOne(type => Project, project => project.polls)
  @JoinColumn()
  project!: Project

  @ManyToOne(type => Vote, vote => vote.poll)
  votes!: Vote[] 
}