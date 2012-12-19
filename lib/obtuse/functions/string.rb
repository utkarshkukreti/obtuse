module Obtuse
  class Evaluator
    # This could be done in a better way.
    fn :Sg, Object, Object, Object do |x, y, z|
      push x.to_s.gsub(y.to_s, z.to_s)
    end

    fn :Sl, String do |x|
      push x.downcase
    end

    fn :Su, String do |x|
      push x.upcase
    end

    fn :Sc, String do |x|
      push x.capitalize
    end

    fn :So, String do |x|
      push x.ord
    end

    fn :Si, Object, Object do |x, y|
      push x.to_s.include?(y.to_s) ? 1 : 0
    end

    # This could also be done in a better way.
    fn :St, Object, Object, Object do |x, y, z|
      push x.to_s.tr(y.to_s, z.to_s)
    end
  end
end
