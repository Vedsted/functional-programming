  type key = string
  type value = int
  type dictionary

  val empty : dictionary
  val add : dictionary -> key -> value -> dictionary
  val find : dictionary -> key -> value