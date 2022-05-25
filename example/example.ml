module NewId (M : Emblem.Ids.IdSig) = struct
  let to_big (e: M.t) =
    M.to_yojson e
end

module type Tag = sig
  val tag : int
end

module Id (M : Tag) = struct
  include Emblem.Ids.Id (struct
    let tag = Z.of_int M.tag
    and tag_len = 3
  end)

  let tag = M.tag
end

module NewerId = Id(struct
  let tag = 1
end)

module WowNewerId = NewId(NewerId)

let () =
   let x = NewerId.gen() in
   let (_: Yojson.Safe.t) = WowNewerId.to_big x  in
   ()

