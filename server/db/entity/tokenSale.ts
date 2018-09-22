import { Entity, Column, BaseEntity, OneToOne, JoinColumn, PrimaryGeneratedColumn } from "typeorm"
import { ObjectType, Field } from "type-graphql"
import { Project } from "./project"

@Entity()
@ObjectType()
export class TokenSale extends BaseEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @OneToOne(type => Project, project => project.tokenSale)
  @JoinColumn()
  project!: Project

  @Column()
  @Field()
  name!: string;

  @Column()
  @Field()
  symbol!: string;

  @Column("bigint")
  @Field()
  supply!: number;

  @Column()
  @Field()
  allocation!: number;

  @Column()
  @Field()
  value!: number;

  @Column("bigint")
  @Field()
  softcap!: number;

  @Column("bigint")
  @Field()
  hardcap!: number;

  @Column("bigint")
  @Field()
  startDate!: number;

  @Column("bigint")
  @Field()
  endDate!: number;
}