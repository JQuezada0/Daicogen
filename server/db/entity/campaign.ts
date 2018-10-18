import { Entity, Column, BaseEntity, OneToOne, PrimaryGeneratedColumn, OneToMany, PrimaryColumn } from "typeorm"
import { ObjectType, Field } from "type-graphql"

@Entity()
@ObjectType()
export class Campaign extends BaseEntity {
  @PrimaryGeneratedColumn()
  @Field()
  id!: number;

  @Column()
  @Field()
  creator!: string;

  @Column()
  @Field()
  category!: string;

  @Column()
  @Field()
  project_title!: string;

  @Column()
  @Field()
  description!: string;

  @Column()
  @Field()
  image!: string;

  @Column("bigint")
  @Field()
  funding_goal!: number;

  @Column("bigint")
  @Field()
  campaign_start!: number;

  @Column("bigint")
  @Field()
  campaign_end!: number;

  @Column()
  @Field()
  title!: string;

  @Column("bigint")
  @Field()
  pledge_amount!: number;

  @Column()
  @Field()
  reward_description!: string;

  @Column("bigint")
  @Field()
  estimated_delivery!: number;
}