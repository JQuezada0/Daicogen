import { Entity, Column, PrimaryColumn } from "typeorm"

@Entity()
export class Test {
  @PrimaryColumn()
  id!: number;

  @Column()
  value!: number;

  @Column()
  owner!: string;
}