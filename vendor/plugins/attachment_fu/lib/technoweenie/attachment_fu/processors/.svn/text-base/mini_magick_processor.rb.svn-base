require 'mini_magick'
module Technoweenie # :nodoc:
  module AttachmentFu # :nodoc:
    module Processors
      module MiniMagickProcessor
        def self.included(base)
          base.send :extend, ClassMethods
          base.alias_method_chain :process_attachment, :processing
        end
        
        module ClassMethods
          # Yields a block containing an MiniMagick Image for the given binary data.
          def with_image(file, &block)
            begin
              binary_data = file.is_a?(MiniMagick::Image) ? file : MiniMagick::Image.from_file(file) unless !Object.const_defined?(:MiniMagick)
            rescue
              # Log the failure to load the image.
              logger.debug("Exception working with image: #{$!}")
              binary_data = nil
            end
            block.call binary_data if block && binary_data
          ensure
            !binary_data.nil?
          end
        end

      protected
        def process_attachment_with_processing
          return unless process_attachment_without_processing
          with_image do |img|
            resize_image_or_thumbnail! img
            self.width  = img[:width] if respond_to?(:width)
            self.height = img[:height]  if respond_to?(:height)
            callback_with_args :after_resize, img
          end if image?
        end

        def resize_image(img, size)
          size = size.first if size.is_a?(Array) && size.length == 1
          if size.is_a?(Fixnum) || (size.is_a?(Array) && size.first.is_a?(Fixnum))
            if size.is_a?(Fixnum)
              resize_and_crop(img, size)
            else
              size[0] == size[1] ? resize_and_crop(img, size[0]) : img.resize(size.join('x'))
            end
          else
            img.resize(size.to_s)
          end
          self.temp_path = img
        end
        
        def resize_and_crop(image, square_size)         
          if image[:width] < image[:height]   
            shave_off = ((image[:height] - image[:width])/2).round 
            image.shave("0x#{shave_off}") 
          elsif image[:width] > image[:height]
            shave_off = ((image[:width] - image[:height])/2).round
            image.shave("#{shave_off}x0")
          end
          image.resize("#{square_size}x#{square_size}!")
          return image
        end

      end
    end
  end
end