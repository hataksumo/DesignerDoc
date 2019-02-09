module("CFG",package.seeall)
LEVELR_FAC_INFO = {}

--======================mainData==========================
LEVELR_FAC_INFO.data = {
	[1] = {id = 1,group = 1,lv = 1,factor = 50},--防御R值
	[2] = {id = 2,group = 1,lv = 2,factor = 52},--防御R值
	[3] = {id = 3,group = 1,lv = 3,factor = 54},--防御R值
	[4] = {id = 4,group = 1,lv = 4,factor = 56},--防御R值
	[5] = {id = 5,group = 1,lv = 5,factor = 58},--防御R值
	[6] = {id = 6,group = 1,lv = 6,factor = 60},--防御R值
	[7] = {id = 7,group = 1,lv = 7,factor = 63},--防御R值
	[8] = {id = 8,group = 1,lv = 8,factor = 66},--防御R值
	[9] = {id = 9,group = 1,lv = 9,factor = 69},--防御R值
	[10] = {id = 10,group = 1,lv = 10,factor = 72},--防御R值
	[11] = {id = 11,group = 1,lv = 11,factor = 75},--防御R值
	[12] = {id = 12,group = 1,lv = 12,factor = 78},--防御R值
	[13] = {id = 13,group = 1,lv = 13,factor = 81},--防御R值
	[14] = {id = 14,group = 1,lv = 14,factor = 85},--防御R值
	[15] = {id = 15,group = 1,lv = 15,factor = 89},--防御R值
	[16] = {id = 16,group = 1,lv = 16,factor = 93},--防御R值
	[17] = {id = 17,group = 1,lv = 17,factor = 97},--防御R值
	[18] = {id = 18,group = 1,lv = 18,factor = 101},--防御R值
	[19] = {id = 19,group = 1,lv = 19,factor = 106},--防御R值
	[20] = {id = 20,group = 1,lv = 20,factor = 111},--防御R值
	[21] = {id = 21,group = 1,lv = 21,factor = 116},--防御R值
	[22] = {id = 22,group = 1,lv = 22,factor = 121},--防御R值
	[23] = {id = 23,group = 1,lv = 23,factor = 127},--防御R值
	[24] = {id = 24,group = 1,lv = 24,factor = 133},--防御R值
	[25] = {id = 25,group = 1,lv = 25,factor = 139},--防御R值
	[26] = {id = 26,group = 1,lv = 26,factor = 145},--防御R值
	[27] = {id = 27,group = 1,lv = 27,factor = 152},--防御R值
	[28] = {id = 28,group = 1,lv = 28,factor = 159},--防御R值
	[29] = {id = 29,group = 1,lv = 29,factor = 166},--防御R值
	[30] = {id = 30,group = 1,lv = 30,factor = 174},--防御R值
	[31] = {id = 31,group = 1,lv = 31,factor = 182},--防御R值
	[32] = {id = 32,group = 1,lv = 32,factor = 191},--防御R值
	[33] = {id = 33,group = 1,lv = 33,factor = 200},--防御R值
	[34] = {id = 34,group = 1,lv = 34,factor = 210},--防御R值
	[35] = {id = 35,group = 1,lv = 35,factor = 220},--防御R值
	[36] = {id = 36,group = 1,lv = 36,factor = 231},--防御R值
	[37] = {id = 37,group = 1,lv = 37,factor = 242},--防御R值
	[38] = {id = 38,group = 1,lv = 38,factor = 254},--防御R值
	[39] = {id = 39,group = 1,lv = 39,factor = 266},--防御R值
	[40] = {id = 40,group = 1,lv = 40,factor = 279},--防御R值
	[41] = {id = 41,group = 1,lv = 41,factor = 292},--防御R值
	[42] = {id = 42,group = 1,lv = 42,factor = 306},--防御R值
	[43] = {id = 43,group = 1,lv = 43,factor = 321},--防御R值
	[44] = {id = 44,group = 1,lv = 44,factor = 337},--防御R值
	[45] = {id = 45,group = 1,lv = 45,factor = 353},--防御R值
	[46] = {id = 46,group = 1,lv = 46,factor = 370},--防御R值
	[47] = {id = 47,group = 1,lv = 47,factor = 388},--防御R值
	[48] = {id = 48,group = 1,lv = 48,factor = 407},--防御R值
	[49] = {id = 49,group = 1,lv = 49,factor = 427},--防御R值
	[50] = {id = 50,group = 1,lv = 50,factor = 448},--防御R值
	[51] = {id = 51,group = 1,lv = 51,factor = 470},--防御R值
	[52] = {id = 52,group = 1,lv = 52,factor = 493},--防御R值
	[53] = {id = 53,group = 1,lv = 53,factor = 517},--防御R值
	[54] = {id = 54,group = 1,lv = 54,factor = 542},--防御R值
	[55] = {id = 55,group = 1,lv = 55,factor = 569},--防御R值
	[56] = {id = 56,group = 1,lv = 56,factor = 597},--防御R值
	[57] = {id = 57,group = 1,lv = 57,factor = 626},--防御R值
	[58] = {id = 58,group = 1,lv = 58,factor = 657},--防御R值
	[59] = {id = 59,group = 1,lv = 59,factor = 689},--防御R值
	[60] = {id = 60,group = 1,lv = 60,factor = 723},--防御R值
	[61] = {id = 61,group = 1,lv = 61,factor = 795},--防御R值
	[62] = {id = 62,group = 1,lv = 62,factor = 874},--防御R值
	[63] = {id = 63,group = 1,lv = 63,factor = 961},--防御R值
	[64] = {id = 64,group = 1,lv = 64,factor = 1057},--防御R值
	[65] = {id = 65,group = 1,lv = 65,factor = 1162},--防御R值
	[66] = {id = 66,group = 1,lv = 66,factor = 1278},--防御R值
	[67] = {id = 67,group = 1,lv = 67,factor = 1405},--防御R值
	[68] = {id = 68,group = 1,lv = 68,factor = 1545},--防御R值
	[69] = {id = 69,group = 1,lv = 69,factor = 1699},--防御R值
	[70] = {id = 70,group = 1,lv = 70,factor = 1868},--防御R值
	[71] = {id = 71,group = 2,lv = 1,factor = 250},--暴击R值
	[72] = {id = 72,group = 2,lv = 2,factor = 262},--暴击R值
	[73] = {id = 73,group = 2,lv = 3,factor = 275},--暴击R值
	[74] = {id = 74,group = 2,lv = 4,factor = 288},--暴击R值
	[75] = {id = 75,group = 2,lv = 5,factor = 302},--暴击R值
	[76] = {id = 76,group = 2,lv = 6,factor = 317},--暴击R值
	[77] = {id = 77,group = 2,lv = 7,factor = 332},--暴击R值
	[78] = {id = 78,group = 2,lv = 8,factor = 348},--暴击R值
	[79] = {id = 79,group = 2,lv = 9,factor = 365},--暴击R值
	[80] = {id = 80,group = 2,lv = 10,factor = 383},--暴击R值
	[81] = {id = 81,group = 2,lv = 11,factor = 402},--暴击R值
	[82] = {id = 82,group = 2,lv = 12,factor = 422},--暴击R值
	[83] = {id = 83,group = 2,lv = 13,factor = 443},--暴击R值
	[84] = {id = 84,group = 2,lv = 14,factor = 465},--暴击R值
	[85] = {id = 85,group = 2,lv = 15,factor = 488},--暴击R值
	[86] = {id = 86,group = 2,lv = 16,factor = 512},--暴击R值
	[87] = {id = 87,group = 2,lv = 17,factor = 537},--暴击R值
	[88] = {id = 88,group = 2,lv = 18,factor = 563},--暴击R值
	[89] = {id = 89,group = 2,lv = 19,factor = 591},--暴击R值
	[90] = {id = 90,group = 2,lv = 20,factor = 620},--暴击R值
	[91] = {id = 91,group = 2,lv = 21,factor = 651},--暴击R值
	[92] = {id = 92,group = 2,lv = 22,factor = 683},--暴击R值
	[93] = {id = 93,group = 2,lv = 23,factor = 717},--暴击R值
	[94] = {id = 94,group = 2,lv = 24,factor = 752},--暴击R值
	[95] = {id = 95,group = 2,lv = 25,factor = 789},--暴击R值
	[96] = {id = 96,group = 2,lv = 26,factor = 828},--暴击R值
	[97] = {id = 97,group = 2,lv = 27,factor = 869},--暴击R值
	[98] = {id = 98,group = 2,lv = 28,factor = 912},--暴击R值
	[99] = {id = 99,group = 2,lv = 29,factor = 957},--暴击R值
	[100] = {id = 100,group = 2,lv = 30,factor = 1004},--暴击R值
	[101] = {id = 101,group = 2,lv = 31,factor = 1054},--暴击R值
	[102] = {id = 102,group = 2,lv = 32,factor = 1106},--暴击R值
	[103] = {id = 103,group = 2,lv = 33,factor = 1161},--暴击R值
	[104] = {id = 104,group = 2,lv = 34,factor = 1219},--暴击R值
	[105] = {id = 105,group = 2,lv = 35,factor = 1279},--暴击R值
	[106] = {id = 106,group = 2,lv = 36,factor = 1342},--暴击R值
	[107] = {id = 107,group = 2,lv = 37,factor = 1409},--暴击R值
	[108] = {id = 108,group = 2,lv = 38,factor = 1479},--暴击R值
	[109] = {id = 109,group = 2,lv = 39,factor = 1552},--暴击R值
	[110] = {id = 110,group = 2,lv = 40,factor = 1629},--暴击R值
	[111] = {id = 111,group = 2,lv = 41,factor = 1710},--暴击R值
	[112] = {id = 112,group = 2,lv = 42,factor = 1795},--暴击R值
	[113] = {id = 113,group = 2,lv = 43,factor = 1884},--暴击R值
	[114] = {id = 114,group = 2,lv = 44,factor = 1978},--暴击R值
	[115] = {id = 115,group = 2,lv = 45,factor = 2076},--暴击R值
	[116] = {id = 116,group = 2,lv = 46,factor = 2179},--暴击R值
	[117] = {id = 117,group = 2,lv = 47,factor = 2287},--暴击R值
	[118] = {id = 118,group = 2,lv = 48,factor = 2401},--暴击R值
	[119] = {id = 119,group = 2,lv = 49,factor = 2521},--暴击R值
	[120] = {id = 120,group = 2,lv = 50,factor = 2647},--暴击R值
	[121] = {id = 121,group = 2,lv = 51,factor = 2779},--暴击R值
	[122] = {id = 122,group = 2,lv = 52,factor = 2917},--暴击R值
	[123] = {id = 123,group = 2,lv = 53,factor = 3062},--暴击R值
	[124] = {id = 124,group = 2,lv = 54,factor = 3215},--暴击R值
	[125] = {id = 125,group = 2,lv = 55,factor = 3375},--暴击R值
	[126] = {id = 126,group = 2,lv = 56,factor = 3543},--暴击R值
	[127] = {id = 127,group = 2,lv = 57,factor = 3720},--暴击R值
	[128] = {id = 128,group = 2,lv = 58,factor = 3906},--暴击R值
	[129] = {id = 129,group = 2,lv = 59,factor = 4101},--暴击R值
	[130] = {id = 130,group = 2,lv = 60,factor = 4306},--暴击R值
	[131] = {id = 131,group = 2,lv = 61,factor = 4736},--暴击R值
	[132] = {id = 132,group = 2,lv = 62,factor = 5209},--暴击R值
	[133] = {id = 133,group = 2,lv = 63,factor = 5729},--暴击R值
	[134] = {id = 134,group = 2,lv = 64,factor = 6301},--暴击R值
	[135] = {id = 135,group = 2,lv = 65,factor = 6931},--暴击R值
	[136] = {id = 136,group = 2,lv = 66,factor = 7624},--暴击R值
	[137] = {id = 137,group = 2,lv = 67,factor = 8386},--暴击R值
	[138] = {id = 138,group = 2,lv = 68,factor = 9224},--暴击R值
	[139] = {id = 139,group = 2,lv = 69,factor = 10146},--暴击R值
	[140] = {id = 140,group = 2,lv = 70,factor = 11160},--暴击R值
	[141] = {id = 141,group = 3,lv = 1,factor = 250},--格挡R值
	[142] = {id = 142,group = 3,lv = 2,factor = 262},--格挡R值
	[143] = {id = 143,group = 3,lv = 3,factor = 275},--格挡R值
	[144] = {id = 144,group = 3,lv = 4,factor = 288},--格挡R值
	[145] = {id = 145,group = 3,lv = 5,factor = 302},--格挡R值
	[146] = {id = 146,group = 3,lv = 6,factor = 317},--格挡R值
	[147] = {id = 147,group = 3,lv = 7,factor = 332},--格挡R值
	[148] = {id = 148,group = 3,lv = 8,factor = 348},--格挡R值
	[149] = {id = 149,group = 3,lv = 9,factor = 365},--格挡R值
	[150] = {id = 150,group = 3,lv = 10,factor = 383},--格挡R值
	[151] = {id = 151,group = 3,lv = 11,factor = 402},--格挡R值
	[152] = {id = 152,group = 3,lv = 12,factor = 422},--格挡R值
	[153] = {id = 153,group = 3,lv = 13,factor = 443},--格挡R值
	[154] = {id = 154,group = 3,lv = 14,factor = 465},--格挡R值
	[155] = {id = 155,group = 3,lv = 15,factor = 488},--格挡R值
	[156] = {id = 156,group = 3,lv = 16,factor = 512},--格挡R值
	[157] = {id = 157,group = 3,lv = 17,factor = 537},--格挡R值
	[158] = {id = 158,group = 3,lv = 18,factor = 563},--格挡R值
	[159] = {id = 159,group = 3,lv = 19,factor = 591},--格挡R值
	[160] = {id = 160,group = 3,lv = 20,factor = 620},--格挡R值
	[161] = {id = 161,group = 3,lv = 21,factor = 651},--格挡R值
	[162] = {id = 162,group = 3,lv = 22,factor = 683},--格挡R值
	[163] = {id = 163,group = 3,lv = 23,factor = 717},--格挡R值
	[164] = {id = 164,group = 3,lv = 24,factor = 752},--格挡R值
	[165] = {id = 165,group = 3,lv = 25,factor = 789},--格挡R值
	[166] = {id = 166,group = 3,lv = 26,factor = 828},--格挡R值
	[167] = {id = 167,group = 3,lv = 27,factor = 869},--格挡R值
	[168] = {id = 168,group = 3,lv = 28,factor = 912},--格挡R值
	[169] = {id = 169,group = 3,lv = 29,factor = 957},--格挡R值
	[170] = {id = 170,group = 3,lv = 30,factor = 1004},--格挡R值
	[171] = {id = 171,group = 3,lv = 31,factor = 1054},--格挡R值
	[172] = {id = 172,group = 3,lv = 32,factor = 1106},--格挡R值
	[173] = {id = 173,group = 3,lv = 33,factor = 1161},--格挡R值
	[174] = {id = 174,group = 3,lv = 34,factor = 1219},--格挡R值
	[175] = {id = 175,group = 3,lv = 35,factor = 1279},--格挡R值
	[176] = {id = 176,group = 3,lv = 36,factor = 1342},--格挡R值
	[177] = {id = 177,group = 3,lv = 37,factor = 1409},--格挡R值
	[178] = {id = 178,group = 3,lv = 38,factor = 1479},--格挡R值
	[179] = {id = 179,group = 3,lv = 39,factor = 1552},--格挡R值
	[180] = {id = 180,group = 3,lv = 40,factor = 1629},--格挡R值
	[181] = {id = 181,group = 3,lv = 41,factor = 1710},--格挡R值
	[182] = {id = 182,group = 3,lv = 42,factor = 1795},--格挡R值
	[183] = {id = 183,group = 3,lv = 43,factor = 1884},--格挡R值
	[184] = {id = 184,group = 3,lv = 44,factor = 1978},--格挡R值
	[185] = {id = 185,group = 3,lv = 45,factor = 2076},--格挡R值
	[186] = {id = 186,group = 3,lv = 46,factor = 2179},--格挡R值
	[187] = {id = 187,group = 3,lv = 47,factor = 2287},--格挡R值
	[188] = {id = 188,group = 3,lv = 48,factor = 2401},--格挡R值
	[189] = {id = 189,group = 3,lv = 49,factor = 2521},--格挡R值
	[190] = {id = 190,group = 3,lv = 50,factor = 2647},--格挡R值
	[191] = {id = 191,group = 3,lv = 51,factor = 2779},--格挡R值
	[192] = {id = 192,group = 3,lv = 52,factor = 2917},--格挡R值
	[193] = {id = 193,group = 3,lv = 53,factor = 3062},--格挡R值
	[194] = {id = 194,group = 3,lv = 54,factor = 3215},--格挡R值
	[195] = {id = 195,group = 3,lv = 55,factor = 3375},--格挡R值
	[196] = {id = 196,group = 3,lv = 56,factor = 3543},--格挡R值
	[197] = {id = 197,group = 3,lv = 57,factor = 3720},--格挡R值
	[198] = {id = 198,group = 3,lv = 58,factor = 3906},--格挡R值
	[199] = {id = 199,group = 3,lv = 59,factor = 4101},--格挡R值
	[200] = {id = 200,group = 3,lv = 60,factor = 4306},--格挡R值
	[201] = {id = 201,group = 3,lv = 61,factor = 4736},--格挡R值
	[202] = {id = 202,group = 3,lv = 62,factor = 5209},--格挡R值
	[203] = {id = 203,group = 3,lv = 63,factor = 5729},--格挡R值
	[204] = {id = 204,group = 3,lv = 64,factor = 6301},--格挡R值
	[205] = {id = 205,group = 3,lv = 65,factor = 6931},--格挡R值
	[206] = {id = 206,group = 3,lv = 66,factor = 7624},--格挡R值
	[207] = {id = 207,group = 3,lv = 67,factor = 8386},--格挡R值
	[208] = {id = 208,group = 3,lv = 68,factor = 9224},--格挡R值
	[209] = {id = 209,group = 3,lv = 69,factor = 10146},--格挡R值
	[210] = {id = 210,group = 3,lv = 70,factor = 11160},--格挡R值
	[211] = {id = 211,group = 4,lv = 1,factor = 500},--闪避R值
	[212] = {id = 212,group = 4,lv = 2,factor = 525},--闪避R值
	[213] = {id = 213,group = 4,lv = 3,factor = 551},--闪避R值
	[214] = {id = 214,group = 4,lv = 4,factor = 578},--闪避R值
	[215] = {id = 215,group = 4,lv = 5,factor = 606},--闪避R值
	[216] = {id = 216,group = 4,lv = 6,factor = 636},--闪避R值
	[217] = {id = 217,group = 4,lv = 7,factor = 667},--闪避R值
	[218] = {id = 218,group = 4,lv = 8,factor = 700},--闪避R值
	[219] = {id = 219,group = 4,lv = 9,factor = 735},--闪避R值
	[220] = {id = 220,group = 4,lv = 10,factor = 771},--闪避R值
	[221] = {id = 221,group = 4,lv = 11,factor = 809},--闪避R值
	[222] = {id = 222,group = 4,lv = 12,factor = 849},--闪避R值
	[223] = {id = 223,group = 4,lv = 13,factor = 891},--闪避R值
	[224] = {id = 224,group = 4,lv = 14,factor = 935},--闪避R值
	[225] = {id = 225,group = 4,lv = 15,factor = 981},--闪避R值
	[226] = {id = 226,group = 4,lv = 16,factor = 1030},--闪避R值
	[227] = {id = 227,group = 4,lv = 17,factor = 1081},--闪避R值
	[228] = {id = 228,group = 4,lv = 18,factor = 1135},--闪避R值
	[229] = {id = 229,group = 4,lv = 19,factor = 1191},--闪避R值
	[230] = {id = 230,group = 4,lv = 20,factor = 1250},--闪避R值
	[231] = {id = 231,group = 4,lv = 21,factor = 1312},--闪避R值
	[232] = {id = 232,group = 4,lv = 22,factor = 1377},--闪避R值
	[233] = {id = 233,group = 4,lv = 23,factor = 1445},--闪避R值
	[234] = {id = 234,group = 4,lv = 24,factor = 1517},--闪避R值
	[235] = {id = 235,group = 4,lv = 25,factor = 1592},--闪避R值
	[236] = {id = 236,group = 4,lv = 26,factor = 1671},--闪避R值
	[237] = {id = 237,group = 4,lv = 27,factor = 1754},--闪避R值
	[238] = {id = 238,group = 4,lv = 28,factor = 1841},--闪避R值
	[239] = {id = 239,group = 4,lv = 29,factor = 1933},--闪避R值
	[240] = {id = 240,group = 4,lv = 30,factor = 2029},--闪避R值
	[241] = {id = 241,group = 4,lv = 31,factor = 2130},--闪避R值
	[242] = {id = 242,group = 4,lv = 32,factor = 2236},--闪避R值
	[243] = {id = 243,group = 4,lv = 33,factor = 2347},--闪避R值
	[244] = {id = 244,group = 4,lv = 34,factor = 2464},--闪避R值
	[245] = {id = 245,group = 4,lv = 35,factor = 2587},--闪避R值
	[246] = {id = 246,group = 4,lv = 36,factor = 2716},--闪避R值
	[247] = {id = 247,group = 4,lv = 37,factor = 2851},--闪避R值
	[248] = {id = 248,group = 4,lv = 38,factor = 2993},--闪避R值
	[249] = {id = 249,group = 4,lv = 39,factor = 3142},--闪避R值
	[250] = {id = 250,group = 4,lv = 40,factor = 3299},--闪避R值
	[251] = {id = 251,group = 4,lv = 41,factor = 3463},--闪避R值
	[252] = {id = 252,group = 4,lv = 42,factor = 3636},--闪避R值
	[253] = {id = 253,group = 4,lv = 43,factor = 3817},--闪避R值
	[254] = {id = 254,group = 4,lv = 44,factor = 4007},--闪避R值
	[255] = {id = 255,group = 4,lv = 45,factor = 4207},--闪避R值
	[256] = {id = 256,group = 4,lv = 46,factor = 4417},--闪避R值
	[257] = {id = 257,group = 4,lv = 47,factor = 4637},--闪避R值
	[258] = {id = 258,group = 4,lv = 48,factor = 4868},--闪避R值
	[259] = {id = 259,group = 4,lv = 49,factor = 5111},--闪避R值
	[260] = {id = 260,group = 4,lv = 50,factor = 5366},--闪避R值
	[261] = {id = 261,group = 4,lv = 51,factor = 5634},--闪避R值
	[262] = {id = 262,group = 4,lv = 52,factor = 5915},--闪避R值
	[263] = {id = 263,group = 4,lv = 53,factor = 6210},--闪避R值
	[264] = {id = 264,group = 4,lv = 54,factor = 6520},--闪避R值
	[265] = {id = 265,group = 4,lv = 55,factor = 6846},--闪避R值
	[266] = {id = 266,group = 4,lv = 56,factor = 7188},--闪避R值
	[267] = {id = 267,group = 4,lv = 57,factor = 7547},--闪避R值
	[268] = {id = 268,group = 4,lv = 58,factor = 7924},--闪避R值
	[269] = {id = 269,group = 4,lv = 59,factor = 8320},--闪避R值
	[270] = {id = 270,group = 4,lv = 60,factor = 8736},--闪避R值
	[271] = {id = 271,group = 4,lv = 61,factor = 9609},--闪避R值
	[272] = {id = 272,group = 4,lv = 62,factor = 10569},--闪避R值
	[273] = {id = 273,group = 4,lv = 63,factor = 11625},--闪避R值
	[274] = {id = 274,group = 4,lv = 64,factor = 12787},--闪避R值
	[275] = {id = 275,group = 4,lv = 65,factor = 14065},--闪避R值
	[276] = {id = 276,group = 4,lv = 66,factor = 15471},--闪避R值
	[277] = {id = 277,group = 4,lv = 67,factor = 17018},--闪避R值
	[278] = {id = 278,group = 4,lv = 68,factor = 18719},--闪避R值
	[279] = {id = 279,group = 4,lv = 69,factor = 20590},--闪避R值
	[280] = {id = 280,group = 4,lv = 70,factor = 22649},--闪避R值
	[281] = {id = 281,group = 5,lv = 1,factor = 10000},--破击R值
	[282] = {id = 282,group = 5,lv = 2,factor = 10000},--破击R值
	[283] = {id = 283,group = 5,lv = 3,factor = 10000},--破击R值
	[284] = {id = 284,group = 5,lv = 4,factor = 10000},--破击R值
	[285] = {id = 285,group = 5,lv = 5,factor = 10000},--破击R值
	[286] = {id = 286,group = 5,lv = 6,factor = 10000},--破击R值
	[287] = {id = 287,group = 5,lv = 7,factor = 10000},--破击R值
	[288] = {id = 288,group = 5,lv = 8,factor = 10000},--破击R值
	[289] = {id = 289,group = 5,lv = 9,factor = 10000},--破击R值
	[290] = {id = 290,group = 5,lv = 10,factor = 10000},--破击R值
	[291] = {id = 291,group = 5,lv = 11,factor = 10000},--破击R值
	[292] = {id = 292,group = 5,lv = 12,factor = 10000},--破击R值
	[293] = {id = 293,group = 5,lv = 13,factor = 10000},--破击R值
	[294] = {id = 294,group = 5,lv = 14,factor = 10000},--破击R值
	[295] = {id = 295,group = 5,lv = 15,factor = 10000},--破击R值
	[296] = {id = 296,group = 5,lv = 16,factor = 10000},--破击R值
	[297] = {id = 297,group = 5,lv = 17,factor = 10000},--破击R值
	[298] = {id = 298,group = 5,lv = 18,factor = 10000},--破击R值
	[299] = {id = 299,group = 5,lv = 19,factor = 10000},--破击R值
	[300] = {id = 300,group = 5,lv = 20,factor = 10000},--破击R值
	[301] = {id = 301,group = 5,lv = 21,factor = 10000},--破击R值
	[302] = {id = 302,group = 5,lv = 22,factor = 10000},--破击R值
	[303] = {id = 303,group = 5,lv = 23,factor = 10000},--破击R值
	[304] = {id = 304,group = 5,lv = 24,factor = 10000},--破击R值
	[305] = {id = 305,group = 5,lv = 25,factor = 10000},--破击R值
	[306] = {id = 306,group = 5,lv = 26,factor = 10000},--破击R值
	[307] = {id = 307,group = 5,lv = 27,factor = 10000},--破击R值
	[308] = {id = 308,group = 5,lv = 28,factor = 10000},--破击R值
	[309] = {id = 309,group = 5,lv = 29,factor = 10000},--破击R值
	[310] = {id = 310,group = 5,lv = 30,factor = 10000},--破击R值
	[311] = {id = 311,group = 5,lv = 31,factor = 10000},--破击R值
	[312] = {id = 312,group = 5,lv = 32,factor = 10000},--破击R值
	[313] = {id = 313,group = 5,lv = 33,factor = 10000},--破击R值
	[314] = {id = 314,group = 5,lv = 34,factor = 10000},--破击R值
	[315] = {id = 315,group = 5,lv = 35,factor = 10000},--破击R值
	[316] = {id = 316,group = 5,lv = 36,factor = 10000},--破击R值
	[317] = {id = 317,group = 5,lv = 37,factor = 10000},--破击R值
	[318] = {id = 318,group = 5,lv = 38,factor = 10000},--破击R值
	[319] = {id = 319,group = 5,lv = 39,factor = 10000},--破击R值
	[320] = {id = 320,group = 5,lv = 40,factor = 10000},--破击R值
	[321] = {id = 321,group = 5,lv = 41,factor = 10000},--破击R值
	[322] = {id = 322,group = 5,lv = 42,factor = 10000},--破击R值
	[323] = {id = 323,group = 5,lv = 43,factor = 10000},--破击R值
	[324] = {id = 324,group = 5,lv = 44,factor = 10000},--破击R值
	[325] = {id = 325,group = 5,lv = 45,factor = 10000},--破击R值
	[326] = {id = 326,group = 5,lv = 46,factor = 10000},--破击R值
	[327] = {id = 327,group = 5,lv = 47,factor = 10000},--破击R值
	[328] = {id = 328,group = 5,lv = 48,factor = 10000},--破击R值
	[329] = {id = 329,group = 5,lv = 49,factor = 10000},--破击R值
	[330] = {id = 330,group = 5,lv = 50,factor = 10000},--破击R值
	[331] = {id = 331,group = 5,lv = 51,factor = 10000},--破击R值
	[332] = {id = 332,group = 5,lv = 52,factor = 10000},--破击R值
	[333] = {id = 333,group = 5,lv = 53,factor = 10000},--破击R值
	[334] = {id = 334,group = 5,lv = 54,factor = 10000},--破击R值
	[335] = {id = 335,group = 5,lv = 55,factor = 10000},--破击R值
	[336] = {id = 336,group = 5,lv = 56,factor = 10000},--破击R值
	[337] = {id = 337,group = 5,lv = 57,factor = 10000},--破击R值
	[338] = {id = 338,group = 5,lv = 58,factor = 10000},--破击R值
	[339] = {id = 339,group = 5,lv = 59,factor = 10000},--破击R值
	[340] = {id = 340,group = 5,lv = 60,factor = 10000},--破击R值
	[341] = {id = 341,group = 5,lv = 61,factor = 10000},--破击R值
	[342] = {id = 342,group = 5,lv = 62,factor = 10000},--破击R值
	[343] = {id = 343,group = 5,lv = 63,factor = 10000},--破击R值
	[344] = {id = 344,group = 5,lv = 64,factor = 10000},--破击R值
	[345] = {id = 345,group = 5,lv = 65,factor = 10000},--破击R值
	[346] = {id = 346,group = 5,lv = 66,factor = 10000},--破击R值
	[347] = {id = 347,group = 5,lv = 67,factor = 10000},--破击R值
	[348] = {id = 348,group = 5,lv = 68,factor = 10000},--破击R值
	[349] = {id = 349,group = 5,lv = 69,factor = 10000},--破击R值
	[350] = {id = 350,group = 5,lv = 70,factor = 10000}--破击R值
}
--=================index__group=================
LEVELR_FAC_INFO.index__group = {
	["1"] = {1,2,3,4,5,6,7,8,
		9,10,11,12,13,14,15,16,
		17,18,19,20,21,22,23,24,
		25,26,27,28,29,30,31,32,
		33,34,35,36,37,38,39,40,
		41,42,43,44,45,46,47,48,
		49,50,51,52,53,54,55,56,
		57,58,59,60,61,62,63,64,
		65,66,67,68,69,70},
	["2"] = {71,72,73,74,75,76,77,78,
		79,80,81,82,83,84,85,86,
		87,88,89,90,91,92,93,94,
		95,96,97,98,99,100,101,102,
		103,104,105,106,107,108,109,110,
		111,112,113,114,115,116,117,118,
		119,120,121,122,123,124,125,126,
		127,128,129,130,131,132,133,134,
		135,136,137,138,139,140},
	["3"] = {141,142,143,144,145,146,147,148,
		149,150,151,152,153,154,155,156,
		157,158,159,160,161,162,163,164,
		165,166,167,168,169,170,171,172,
		173,174,175,176,177,178,179,180,
		181,182,183,184,185,186,187,188,
		189,190,191,192,193,194,195,196,
		197,198,199,200,201,202,203,204,
		205,206,207,208,209,210},
	["4"] = {211,212,213,214,215,216,217,218,
		219,220,221,222,223,224,225,226,
		227,228,229,230,231,232,233,234,
		235,236,237,238,239,240,241,242,
		243,244,245,246,247,248,249,250,
		251,252,253,254,255,256,257,258,
		259,260,261,262,263,264,265,266,
		267,268,269,270,271,272,273,274,
		275,276,277,278,279,280},
	["5"] = {281,282,283,284,285,286,287,288,
		289,290,291,292,293,294,295,296,
		297,298,299,300,301,302,303,304,
		305,306,307,308,309,310,311,312,
		313,314,315,316,317,318,319,320,
		321,322,323,324,325,326,327,328,
		329,330,331,332,333,334,335,336,
		337,338,339,340,341,342,343,344,
		345,346,347,348,349,350}
}