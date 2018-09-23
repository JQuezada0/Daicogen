import { Entity, Column, BaseEntity, OneToOne, PrimaryGeneratedColumn, OneToMany, PrimaryColumn } from "typeorm"
import { ObjectType, Field } from "type-graphql"
import { TokenSale } from "./tokenSale"
import { Poll } from "./poll"

@Entity()
@ObjectType()
export class Project extends BaseEntity {
  @PrimaryColumn()
  @Field()
  owner!: string;

  @Column()
  @Field()
  name!: string;

  @Column()
  @Field()
  description!: string;

  @Column()
  @Field()
  url!: string;

  @Column()
  @Field()
  whitepaperUrl!: string;

  @Column()
  @Field()
  tapVoterTurnout!: number;

  @Column()
  @Field()
  tapThreshold!: number;

  @Column()
  @Field()
  tapMaxIncrease!: number;

  @Column("bigint")
  @Field()
  tapVoteDuration!: number;

  @Column()
  @Field()
  refundFrequency!: string;

  @Column()
  @Field()
  maxNumRefunds!: number;

  @Column("bigint")
  @Field()
  refundVoteDuration!: number;

  @Column()
  @Field()
  refundVoterTurnout!: number;

  @Column()
  @Field()
  refundThreshold!: number;

  // @OneToOne(type => TokenSale, tokenSale => tokenSale.project)
  // tokenSale!: TokenSale

  @OneToMany(type => Poll, poll => poll.project, { onDelete: 'CASCADE' })
  polls!: Poll[]
}