import libsg

func readFile(named name: String) {
  guard
    let file = sg_read_file(name)
  else {
    return print("Could not open file \(name)")
  }

  print("File \(name) contains \(sg_get_file_bitmap_count(file)) bitmaps and \(sg_get_file_image_count(file)) images")

  sg_delete_file(file)
}
