# encoding: utf-8

#  Copyright 2012 Stanislav Senotrusov <stan@senotrusov.com>
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.


require 'matrix'

module StanApplicationHelper
  def hidden? name
    @hide && @hide.include?(name)
  end

  def topmost_controller
    if user_signed_in? && matchdata = request.fullpath.match(/\A\/([^\/\?]+)/)
      matchdata[1]
    end
  end
  
  def flag_attr name, value
    value ? {name => true} : {}
  end

  def options things
    things.is_a?(Hash) ? things.map{|k,v| [v, k]} : things.map(&:option_for_select)
  end

  def start_year date
    date && date.year || @now && @now.year || Time.zone.now.year
  end

  def filter_empty_columns data
    Matrix.columns(Matrix.rows(data).column_vectors.select{|column| column.any?}).to_a
  end

  def title_content_titled(title)
    if (t = content_for(:title)).blank?
      title
    else
      safe_join([t, title], ' - ')
    end
  end

  def crarred text
    safe_join(text.split(/\n/), '<span class=crarr>&crarr;</span><br>'.html_safe) if text
  end

  def scale value, scale = 2
    if value
      "%.#{scale}f" % value
    end
  end

  def scale_if_needed value, scale = 2
    value.class == BigDecimal ? scale(value, scale) : value
  end
  
  def hellip string, length = 60
    if string
      if string.length <= length
        string
      else
        string[0,length] + '…'
      end
    end
  end
  
  def time_with_distance time, sep = br_tag
    if time
      @now ||= Time.zone.now
      direction = @now >= time ? 'ago' : 'until that'
    
      safe_join([distance_of_time_in_words(time, @now) + ' ' + direction, time.to_s[0..15]], sep)
    end
  end
  
  def br_tag
    "<br>".html_safe
  end

  def hr_tag
    "<hr>".html_safe
  end

  def title model, attribute = nil
    if attribute
      if /\A(?<association>.*)_id\z/ =~ attribute.to_s
        model = model.send(association)
      else
        model = model.send(attribute)
      end
    end

    model.respond_to?(:title) && model.title || model
  end

  def inline_attribute_name model, attribute
    content_tag(:strong, model.class.human_attribute_name(attribute) + ":") + " "
  end
end
