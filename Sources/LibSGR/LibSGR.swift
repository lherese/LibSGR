import libsg

func readFile(named name: String) {

  guard
    let file = SGFile(name)
  else {
    return print("Could not open file \(name)")
  }

  print("File \(name) contains \(file.bitmapCount) bitmaps and \(file.imageCount) images")

  let index: UInt32 = 0
  guard
    let image = file[image: 0]
  else {
    return print("Could not load image \(index)")
  }

  print("Image \(index) is \(image.width) by \(image.height) pixels")
}
