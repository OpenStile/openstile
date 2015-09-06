module StyleProfilesHelper

  def idify attribute_string, value=nil
    ret = attribute_string.gsub(/(\[|\])+/,'_').gsub(/_$/,'')
    unless value.nil?
      ret = "#{ret}_#{value}"
    end
    ret
  end
end
