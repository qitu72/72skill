# skill-sync

> 涓€濂楁妧鑳藉簱锛屽澶?AI Agent 鍏辩敤銆傛敼涓€澶勶紝澶勫鍚屾銆?>
> Keep **one** skill library in sync across **many** AI agents.

[![Python 3.8+](https://img.shields.io/badge/python-3.8%2B-blue)](https://www.python.org/)
[![No dependencies](https://img.shields.io/badge/dependencies-none-brightgreen)]()
[![License: MIT](https://img.shields.io/badge/license-MIT-green)](LICENSE)

---

## 涓轰粈涔堥渶瑕佸畠 / Why

鐜板湪鍚屾椂鐢ㄥ涓?AI Agent 鏄父鎬侊細Claude Code銆丆odex銆乄orkBuddy銆丆odeBuddy銆丄utoClaw銆丆ursor鈥︹€?*姣忎釜 Agent 鍚勮嚜缁存姢涓€浠借嚜宸辩殑 skill 鐩綍**銆?
浜庢槸鍚屼竴涓?`SKILL.md` 鍦ㄤ綘鐨勬満鍣ㄤ笂瀛樺湪 N 浠藉壇鏈€傛敼浜嗗叾涓竴浠斤紝鍏朵粬鍑犱唤涓嶄細鑷姩璺熺潃鍙樷€斺€旀椂闂翠竴闀匡紝鍚勭鐨勬妧鑳界増鏈紑濮嬫紓绉伙紝浣犱細閬囧埌锛?
- 鍦?A 瀹㈡埛绔慨濂界殑鎶€鑳斤紝鍒?B 瀹㈡埛绔繕鏄棫鐗?- 鍚屽悕 `SKILL.md` 鍐呭涓嶄竴鑷达紝鍗存病浜虹煡閬撹淇″摢浠?- 鎵嬪伐澶嶅埗绮樿创锛岃繜鏃╂紡鎺変竴涓?
`skill-sync` 鎶婅繖浠朵簨鍙樻垚涓€鏉″懡浠ゃ€?
**璁捐鍓嶆彁锛氭瘡涓汉鐨?Agent 缁勫悎閮戒笉涓€鏍枫€?* 鎵€浠ユ湰宸ュ叿**涓嶇‖缂栫爜浠讳綍璺緞**鈥斺€斿畠鍏堝仛涓€娆°€屾暟鎹敹闆嗐€嶏紙`discover`锛夋帰娴嬩綘鏈哄櫒涓婄湡瀹炲瓨鍦ㄧ殑 Agent 鎶€鑳藉簱锛屾妸缁撴灉瀛樿繘娉ㄥ唽琛紝涔嬪悗鎵€鏈夊悓姝ユ寜娉ㄥ唽琛ㄨ蛋銆?
---

## 瀹夎 / Install

闆剁涓夋柟渚濊禆锛屾爣鍑嗗簱鍗冲彲杩愯銆?
```bash
# 鏂瑰紡涓€锛氫笉瀹夎锛岀洿鎺ヨ窇锛堟帹鑽愬厛璇曡繖涓級
git clone https://cnb.cool/72boom/72skill.git && cd 72skill/skill-sync
python -m skill_sync discover

# 鏂瑰紡浜岋細瀹夎鍚庣敤鍛戒护
pip install .
skill-sync discover
```

> Windows 鐢ㄦ埛涔熷彲鐢?`py -m skill_sync`銆?
---

## 蹇€熷紑濮?/ Quick start

```bash
# 1. 鏁版嵁鏀堕泦锛氭帰娴嬫湰鏈烘湁鍝簺 Agent 鎶€鑳藉簱锛堜氦浜掑紡鍕鹃€夛級
skill-sync discover

# 2. 鐪嬬湅鍚勭婕傜Щ鎯呭喌锛堝彧璇伙紝涓嶆敼鍔ㄤ换浣曟枃浠讹級
skill-sync status

# 3. 鍚屾
skill-sync sync --dry-run    # 鍏堝共璺戯紝鐪嬩細鏀逛粈涔?skill-sync sync              # 纭鏃犺鍚庣湡璺?```

`discover` 浼氭壂鎻忓凡鐭?Agent 鐨勫父瑙佷綅缃紝渚嬪锛?
| Agent | 榛樿璺緞 |
|---|---|
| WorkBuddy | `~/.workbuddy/skills` |
| CodeBuddy | `~/.codebuddy/skills` |
| AutoClaw / OpenClaw | `~/.openclaw-autoclaw/skills` |
| DeepSeek Harness | `~/.dsh/skills` |
| Claude Code | `~/.claude/skills` |
| Codex CLI | `~/.codex/skills` |
| Gemini CLI | `~/.gemini/skills` |
| Cursor | `~/.cursor/skills` |
| Windsurf | `~/.windsurf/skills` |
| Cline | `~/.cline/skills` |
| Roo Code | `~/.roo/skills` |

鎺㈡祴涓嶅埌鐨勶紵鎵嬪伐鐧昏鍗冲彲锛?
```bash
skill-sync add ~/some/agent/skills --name "My Agent"
```

---

## 鍛戒护 / Commands

| 鍛戒护 | 浣滅敤 |
|---|---|
| `discover` | **鏁版嵁鏀堕泦**锛氭壂鎻忔湰鏈哄凡鐭?Agent 鎶€鑳藉簱锛屼氦浜掑紡纭鍚庡啓鍏ユ敞鍐岃〃 |
| `list` | 鍒楀嚭宸茬櫥璁扮殑搴撳強鍏舵妧鑳芥暟閲?|
| `status` | 鍙鎶ュ憡锛氬摢浜涙枃浠朵竴鑷?/ 缂哄け / 鍐呭鍐茬獊 |
| `sync` | 鍙屽悜澧為噺鍚屾锛坢time 鏂拌€呰儨锛?|
| `sync --dry-run` | 骞茶窇锛屽彧鐪嬩細鏀逛粈涔?|
| `sync --from <id>` | 鍗曞悜锛氫互鎸囧畾搴撲负鍑嗗己鍒惰鐩栧叾浠栧簱锛堜細鍏堝浠斤級 |
| `add <path>` | 鎵嬪伐鐧昏涓€涓妧鑳藉簱 |
| `remove <key>` | 浠庢敞鍐岃〃绉婚櫎锛堝彧绉婚櫎鐧昏锛屼笉鍒犳枃浠讹級 |

娉ㄥ唽琛ㄤ綅缃細`~/.skill-sync/registry.json`锛堝彲鐩存帴缂栬緫锛屼篃鍙敤 `SKILL_SYNC_HOME` 鐜鍙橀噺鏀逛綅缃級銆?
---

## 鍚屾瑙勫垯 / Rules

杩欏嚑鏉℃槸鍒绘剰璁捐鐨勶紝涔熸槸鏈伐鍏风殑瀹夊叏搴曠嚎锛?
1. **mtime 鏂拌€呰儨** 鈥斺€?鍙屽悜澧為噺鍚屾锛屼慨鏀规椂闂存洿鏂扮殑鐗堟湰瑕嗙洊鏃х殑銆備笉鍋氬唴瀹瑰悎骞躲€?2. **缁濅笉鍒犻櫎** 鈥斺€?鍙瓨鍦ㄤ簬鏌愪竴绔殑鎶€鑳戒細鍘熸牱淇濈暀銆傝繖鏄负浠€涔堟垜浠笉鎻愪緵 `--mirror`锛氬悇 Agent 鏈潵灏辨湁鑷繁鐙湁鐨勬妧鑳斤紝闈欓粯鍒犻櫎鏄伨闅俱€?3. **鍐茬獊缁濅笉闈欓粯瑕嗙洊** 鈥斺€?鍚屾鍚庝細鍐嶆牎楠屼竴娆″搱甯岋紱鑻ュ悓鍚嶆枃浠跺唴瀹逛粛涓嶄竴鑷达紙渚嬪 mtime 鐩稿悓浣嗗唴瀹逛笉鍚岋級锛?*鍙姤鍛娿€佷笉瑕嗙洊**锛屼氦缁欎綘浜哄伐瑁佸喅銆?4. **璺宠繃瀹㈡埛绔厓鏁版嵁** 鈥斺€?`*.bundled-hash`銆乣_user_meta.json`銆乣_bm_skillid_migration.json*`銆乣.DS_Store`銆乣__pycache__` 绛変笉鍙備笌鍚屾锛岄伩鍏嶄簰鐩告薄鏌撳悇瀹㈡埛绔殑鍚敤鐘舵€併€?5. **涓嶈窡闅忕鍙烽摼鎺?/ junction** 鈥斺€?鏈変簺 Agent 浼氱敤 junction 浜掔浉鎸囧悜锛岃窡闅忎細閫犳垚鏃犻檺閬嶅巻鎴栭噸澶嶅啓鍏ワ紝涓€寰嬭烦杩囥€?
`--from` 鍗曞悜妯″紡鏄?*鍞竴浼氳鐩栬緝鏂版枃浠?*鐨勬ā寮忥紝鍥犳瀹冧細鍏堟妸琚浛鎹㈢殑鏂囦欢瀛樹负 `.bak-skillsync-<鏃堕棿鎴?`锛岀‘淇濆彲鍥為€€銆?
---

## 璁?Agent 鑷繁璋冪敤 / Agent integration

`skills/skills-sync/SKILL.md` 鏄竴涓幇鎴愮殑鎶€鑳藉畾涔夛紝瑁呰繘浣犵殑 Agent 鎶€鑳藉簱鍚庯紝鐩存帴瀵?Agent 璇淬€屽悓姝ユ妧鑳藉簱銆嶅嵆鍙Е鍙戙€?
```bash
# 鎶婃妧鑳藉畾涔夋斁杩涙煇涓?Agent锛堢劧鍚?sync 涓€娆★紝瀹冨氨鑷姩鍒嗗彂鍒版墍鏈夌锛?mkdir -p ~/.claude/skills/skills-sync
cp skills/skills-sync/SKILL.md ~/.claude/skills/skills-sync/
skill-sync sync
```

鏈夌偣鑷妇鐨勫懗閬擄細杩欎釜鍚屾鎶€鑳芥湰韬紝涔熺敱杩欏宸ュ叿鍚屾銆?
---

## 鏂板涓€涓?Agent / Contributing an agent

濡傛灉浣犵敤鐨?Agent 涓嶅湪涓婇潰鐨勮〃閲岋紝鏈変袱绉嶆柟寮忥細

**1. 鏈湴鎵╁睍锛堟棤闇€鏀逛唬鐮侊級** 鈥斺€?缂栬緫 `data/known_agents.json`锛?
```json
{
  "agents": [
    { "id": "my-agent", "name": "My Agent", "path": "{home}/.my-agent/skills" }
  ]
}
```

**2. 鎻?PR** 鈥斺€?鐩存帴寰€ `skill_sync/agents.py` 鐨?`KNOWN_AGENTS` 鍔犱竴琛岋紝璁╂墍鏈変汉鍙楃泭銆?
`path` 鏀寔鍗犱綅绗︼細`{home}`锛堢敤鎴蜂富鐩綍锛夈€乣{cwd}`锛堝綋鍓嶇洰褰曪級銆?
---

## 骞冲彴鏀寔 / Platforms

| 骞冲彴 | 鏀寔 | 璇存槑 |
|---|---|---|
| Windows | 鉁?| 宸插鐞?junction 涓庣洏绗﹁矾寰?|
| macOS | 鉁?| |
| Linux | 鉁?| |
| iOS / Android | 鉂?| 绉诲姩绔矙鐩掗噷 App 涔嬮棿鐩綍浜掍笉鍙锛屼篃娌℃湁甯歌缁堢锛屾棤娉曞仛璺?App 鐩綍鍚屾 |

---

## 瀹夊叏 / Safety

- 榛樿**鍙涓嶅垹**锛涘敮涓€浼氳鐩栫殑鏄€屽悓涓€鏂囦欢銆佸绔洿鏃с€嶇殑鎯呭喌銆?- 鍐茬獊涓€寰嬫姤鍛婏紝涓嶈嚜鍔ㄨ鍐炽€?- `--from` 鏄敮涓€寮哄埗妯″紡锛屼細鑷姩澶囦唤琚浛鎹㈡枃浠躲€?- 寤鸿棣栨浣跨敤鍏堣窇 `status` 鍜?`sync --dry-run`锛岀湅娓呬細鍙戠敓浠€涔堝啀鐪熻窇銆?- 鎶€鑳藉簱閲屽鏋滄湁浣犵殑绉佸瘑鍐呭锛屾敞鎰忓悓姝ヤ細鎶婂畠鍦ㄥ涓鎴风涔嬮棿鎽婂钩銆?
---

## 璁稿彲 / License

MIT 鈥斺€?瑙?[LICENSE](LICENSE)銆?