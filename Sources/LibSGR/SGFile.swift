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
      let image: Image
      let data: UnsafeMutablePointer<SgImageData>

      init?(image: Image) {
        guard
          let data = sg_load_image_data(image.image, image.file.name)
        else {
          return nil
        }

        self.image = image
        self.data = data
      }

      public var width: UInt16 {
        data.pointee.width
      }

      public var height: UInt16 {
        data.pointee.height
      }

      public var pixels: Array<Pixel> {
        Array(UnsafeMutableBufferPointer<UInt32>(start: data.pointee.data, count: Int(width * height)))
          .map { Pixel($0) }
      }

      deinit {
        sg_delete_image_data(data)
      }
    }

    public struct Pixel {
      let alpha: UInt8
      let red: UInt8
      let green: UInt8
      let blue: UInt8

      init(_ data: UInt32) {
        alpha = UInt8((data & 0xff000000) >> 24)
        red   = UInt8((data & 0x00ff0000) >> 16)
        green = UInt8((data & 0x0000ff00) >>  8)
        blue  = UInt8((data & 0x000000ff) >>  0)
      }
    }

    let file: SGFile
    let image: OpaquePointer

    init(file: SGFile, _ pointer: OpaquePointer) {
      self.file = file
      self.image = pointer
    }

    public var width: UInt16 {
      sg_get_image_width(image)
    }

    public var height: UInt16 {
      sg_get_image_height(image)
    }

    public var data: Data? {
      Data(image: self)
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
