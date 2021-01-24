## Emblem

Emblem is a tiny library for 128 bit uuid similar ids that roughly ordered and can be typed. It is is inspired by snowflake, timeflake and other similar distributed id creation ideas. Emblem works has one slightly different exception in that it allows a tag to be inserted into it as well to allow ids classes to be visually identified by the tailing characters and ids to be typed with machine verification. Emblem allocates 40 bits to the timestamp, and then a variable amount to the tag with the rest being used for randomness. Tags must be unique amoung modules created to verify properly and all tags set must share the sample tag_len for proper usage. A small example of it in usage is below.

Emblems are similar in size to a uuid but feature several benefits, they can be sorted by time & time can be recoverd, they can be generated in a distributed fashion due to the low chance of collision. they can potentially avoid id collision between data classes and they are suitable for fast insertion into a sql database at scale.

```
─( 19:21:07 )─< command 0 >────{ counter: 0 }─
utop # module TestA = Emblem.Ids.Id(struct let tag = (Z.of_int 0) and tag_len = 3 end);;
module TestA :
  sig
    type t = private Z.t
    val gen : unit -> t
    val get_time : t -> float
    val get_random : t -> Z.t
    val get_tag : t -> Z.t
    val to_raw_string : t -> string
    val to_hex_string : t -> string
    val to_uuid_string : t -> string
    val to_z : t -> Z.t
    val of_raw_string : string -> (t, [> Emblem.Ids.R.msg ]) result
    val of_z : Z.t -> (t, [> Rresult.R.msg ]) result
    val eq : t -> t -> bool
    val compare : t -> t -> int
    val pp : Format.formatter -> t -> unit
    val db_column : string -> (t, string) Ezmysql.Column.spec
  end
─( 19:21:07 )─< command 1 >
utop # module TestB = Emblem.Ids.Id(struct let tag = (Z.of_int 1) and tag_len = 3 end);;
module TestB :
  sig
    ... (* Same as above, so trimmed. *)
  end
─( 19:21:13 )─< command 2 >
utop # let a = TestA.gen ();;
val a : TestA.t = <abstr>
─( 19:21:19 )─< command 3 >
utop # let b = TestB.gen ();;
val b : TestB.t = <abstr>
─( 19:21:34 )─< command 4 >
utop # TestA.to_uuid_string a;;
- : string = "017731fb-6149-1ec2-02cd-719569dc0000"
─( 19:21:39 )─< command 5 >
utop # TestB.to_uuid_string b;;
- : string = "017731fb-74d2-30f3-6797-1a554ee41001"
─( 19:21:44 )─< command 6 >
utop # TestA.of_raw_string (TestB.to_raw_string b);;
- : (TestA.t, [> Rresult.R.msg ]) result =
Error (`Msg "Tag (1) doesn't match emblem tag (0).")
─( 19:21:49 )─< command 7 >
utop # TestA.get_time a;;
- : float = 1611451294025.
```
