import libsg

func printImage(file: SGFile, index: UInt32) {
  guard
    let image = file[image: index]
  else {
    return print("Could not load image \(index)")
  }

  let (height, width) = (image.height - 1, image.width - 1)

  print("Image \(index) is \(image.width) by \(image.height) pixels")

  guard
    let data = image.data
  else {
    return print("Could not load image data")
  }

  let pixels = data.pixels

  for j in 0...height {
    var line = ""

    for i in 0...width {
      if pixels[Int(j * width + i)].alpha > 0 {
        line += "#"
      } else {
        line += " "
      }
    }

    print(line)
  }
}

func readFile(named name: String) {

  guard
    let file = SGFile(name)
  else {
    return print("Could not open file \(name)")
  }

  print("File \(name) contains \(file.bitmapCount) bitmaps and \(file.imageCount) images")

  for index in 0...(file.imageCount - 1) {
    printImage(file: file, index: index)
  }
}
