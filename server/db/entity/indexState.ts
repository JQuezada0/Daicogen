import { Entity, Column, PrimaryGeneratedColumn } from "typeorm"

@Entity("_index_state")
export class IndexState {
  @PrimaryGeneratedColumn()
  id!: number

  @Column()
  block_number!: number

  @Column("text")
  block_hash!: string

  @Column()
  is_replay!: boolean
}