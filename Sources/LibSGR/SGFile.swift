import libsg

public class SGFile {
  public class Bitmap {
    let file: SGFile
    let bitmap: OpaquePointer

    init(file: SGFile, _ pointer: OpaquePointer) {
      self.file = file
      self.bitmap = pointer
    }
  }

  public class Image {
    public class Data {
      let data: UnsafeMutablePointer<SgImageData>

      init?(image: Image, file: SGFile) {
        guard
          let data = sg_load_image_data(image.image, file.name)
        else {
          return nil
        }

        self.data = data
      }

      deinit {
        sg_delete_image_data(data)
      }
    }

    let file: SGFile
    let image: OpaquePointer

    init(file: SGFile, _ pointer: OpaquePointer) {
      self.file = file
      self.image = pointer
    }

    var width: UInt16 {
      sg_get_image_width(image)
    }

    var height: UInt16 {
      sg_get_image_height(image)
    }
  }

  let name: String
  let file: OpaquePointer

  public init?(_ filename: String) {
    guard
      let file = sg_read_file(filename)
    else {
      return nil
    }

    self.name = filename
    self.file = file
  }

  deinit {
    sg_delete_file(file)
  }

  var imageCount: UInt32 {
    sg_get_file_image_count(file)
  }

  var bitmapCount: UInt32 {
    sg_get_file_bitmap_count(file)
  }

  subscript(image n: UInt32) -> Image? {
    sg_get_file_image(file, n)
      .map { Image(file: self, $0) }
  }

  subscript(bitmap n: UInt32) -> Bitmap? {
    sg_get_file_bitmap(file, n)
      .map { Bitmap(file: self, $0) }
  }
}
