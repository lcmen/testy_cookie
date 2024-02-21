module TestyCookie
  class Proxy < SimpleDelegator
    def initialize(cookies, raw_cookies, parent)
      super(cookies)
      @parent = parent
      @raw_cookies = raw_cookies
    end

    def []=(key, value)
      super
      assign(key)
    end

    def encrypted
      self.class.new(__getobj__.encrypted, @raw_cookies, self)
    end

    def permanent
      self.class.new(__getobj__.permanent, @raw_cookies, self)
    end

    def signed
      self.class.new(__getobj__.signed, @raw_cookies, self)
    end

    def assign(key)
      if @parent.present?
        @parent.assign(key)
      else
        @raw_cookies[key] = __getobj__[key]
      end
    end
  end
end
