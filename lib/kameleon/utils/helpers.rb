def one_or_all(elements)
  elements.is_a?(Array) ? elements : [elements]
end



def extract_options(opts)
  if opts.size == 1
    opts.first
  else
    opts
  end
end