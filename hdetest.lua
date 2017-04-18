local hde = require("hde64")

function popn(tab, n)
  for i=n,#tab do
    tab[i-n] = tab[i]
  end
  for i=(#tab-n+1),#tab do
    tab[i] = nil
  end
end

local code = { [0] = 0x55,
                     0x48, 0x89, 0xe5,
                     0x53,
                     0x48, 0x83, 0xec, 0x28,
                     0xc7, 0x45, 0xec, 0x00, 0x00, 0x00, 0x00,
                     0x89, 0x7d, 0xe0,
                     0x48, 0x89, 0x75, 0xd8,
                     0xe8, 0xe4, 0xfd, 0xff, 0xff,
                     0x48, 0x89, 0x45, 0xf0,
                     0x48, 0x85, 0xc0,
                     0x0f, 0x84, 0x9c, 0x00, 0x00, 0x00,
                     0x48, 0x8b, 0x7d, 0xf0,
                     0xe8, 0x0e, 0xfc, 0xff, 0xff,
                     0x48, 0x8b, 0x7d, 0xf0,
                     0xe8, 0xc5, 0xfc, 0xff, 0xff,
                     0x48, 0x8b, 0x7d, 0xf0,
                     0x48, 0x8d, 0x35, 0x1a, 0x01, 0x00, 0x00,
                     0x31, 0xdb,
                     0x31, 0xd2,
                     0xe8, 0x11, 0xfe, 0xff, 0xff,
                     0x48, 0x8b, 0x7d, 0xf0,
                     0x48, 0x63, 0x75, 0xe0,
                     0xe8, 0x34, 0xfe, 0xff, 0xff,
                     0x48, 0x8b, 0x7d, 0xf0,
                     0x48, 0x8b, 0x75, 0xd8,
                     0xe8, 0x17, 0xfe, 0xff, 0xff,
                     0x48, 0x8b, 0x7d, 0xf0,
                     0xbe, 0x02, 0x00, 0x00, 0x00,
                     0xba, 0x01, 0x00, 0x00, 0x00,
                     0x31, 0xc9,
                     0x45, 0x31, 0xc0,
                     0x45, 0x31, 0xc9,
                     0xe8, 0xcc, 0xfb, 0xff, 0xff,
                     0x89, 0x45, 0xe8,
                     0x48, 0x8b, 0x7d, 0xf0,
                     0xbe, 0xff, 0xff, 0xff, 0xff,
                     0xe8, 0x2b, 0xfd, 0xff, 0xff,
                     0x89, 0x45, 0xe4,
                     0x48, 0x8b, 0x7d, 0xf0,
                     0x8b, 0x75, 0xe8,
                     0xe8, 0x5c, 0x02, 0x00, 0x00,
                     0x48, 0x8b, 0x7d, 0xf0,
                     0xe8, 0x13, 0xfc, 0xff, 0xff,

                     0x48, 0x8b, 0x45, 0xe0,
                     0x48, 0x83, 0x38, 0x00,
                     0x74, 0x1a,
                     0x48, 0x8b, 0x45, 0xe0,
                     0x48, 0x8b, 0x00,
                     0x80, 0x38, 0x00,
                     0x74, 0x0e,
                     0x48, 0x8b, 0x45, 0xe0,
                     0x48, 0x8b, 0x00,
                     0x48, 0x89, 0x05, 0xb2, 0x27, 0x20, 0x00,
                     0x83, 0x7d, 0xfc, 0x01,
                     0x75, 0x1d,
                     0x48, 0x63, 0x45, 0xf8,
                     0x48, 0x8b, 0x4d, 0xe0,
                     0x48, 0x8b, 0x3c, 0xc1,
                     0xe8, 0xd3, 0x02, 0x00, 0x00,
                     0xc7, 0x45, 0xec, 0x00, 0x00, 0x00, 0x00,
                     0xe9, 0xe7, 0x00, 0x00, 0x00,
                     0xf6, 0x45, 0xfc, 0x04,
                     0x74, 0x05,
                     0xe8, 0x5c, 0x03, 0x00, 0x00,
                     0xf6, 0x45, 0xfc, 0x10,
                     0x74, 0x23,
                     0x48, 0x8b, 0x7d, 0xf0,
                     0xbe, 0x01, 0x00, 0x00, 0x00,
                     0xe8, 0x48, 0xfa, 0xff, 0xff,
             }
local l = 0
while #code > 0 do
  local len, hde64s = hde.disasm(code)
  -- hde64s:dump()
  print("len:", len, string.format("opcode: %x", hde64s.opcode))
  popn(code, len)
end
