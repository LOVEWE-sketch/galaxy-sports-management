# News Content Templates for Galaxy Sports Management

## Overview
Add player stories, trial announcements, and academy placements to the news section. News items are stored in `data/projects.json` under the `news[]` array.

---

## Template 1: Player Trial Announcement

```json
{
  "id": 3,
  "title": "[Player Name] Secures Trial at [Club Name]",
  "date": "2025-01-15",
  "excerpt": "[Player Name], [age]-year-old [position] from [country], has secured a trial opportunity at [Club Name] in [country/league].",
  "content": "We're thrilled to announce that [Player Full Name], a talented [age]-year-old [position] from [country], has been offered a trial at [Club Name], competing in [league/division].\n\n[Player Name] impressed scouts with [specific achievement or skill - e.g., 'his exceptional pace and finishing ability' or 'her tactical awareness and defensive positioning']. The trial will take place from [start date] to [end date], giving [him/her] the opportunity to showcase [his/her] abilities to the club's coaching staff.\n\n\"This is a fantastic opportunity for [Player Name],\" said [Agent Name, e.g., Ajayi Adeniran], CEO of Galaxy Sports Management. \"[He/She] has worked incredibly hard, and we're confident [he/she] will make a strong impression.\"\n\nThe trial includes training sessions with the first team squad and participation in practice matches. We wish [Player Name] the very best of luck!\n\n📍 Club: [Club Name]\n🏆 League: [League/Division Name]\n📅 Trial Period: [Dates]\n⚽ Position: [Position]\n🌍 Location: [City, Country]",
  "image": "trial-[player-name].jpg",
  "category": "trials"
}
```

**Example Image Caption Ideas:**
- "Player-name in action during training"
- "Player-name celebrates after scoring"
- "Player-name with Galaxy Sports Management representatives"

---

## Template 2: Academy Placement Success

```json
{
  "id": 4,
  "title": "[Player Name] Joins [Academy Name] Development Program",
  "date": "2025-01-20",
  "excerpt": "Young talent [Player Name] has been accepted into [Academy Name]'s prestigious youth development program.",
  "content": "Galaxy Sports Management is proud to announce that [Player Name], a promising [age]-year-old [position], has been accepted into [Academy Name]'s elite youth development program.\n\n[Player Name] joins [Academy Name] on a [duration, e.g., 'two-year'] development contract, where [he/she] will receive professional coaching, educational support, and pathways to professional football.\n\nThe academy, known for producing [mention notable alumni if applicable, e.g., 'several professional players including...' or 'talent that has gone on to compete in top European leagues'], operates one of the most respected youth programs in [country/region].\n\n\"We're delighted to see [Player Name] take this important step in [his/her] career,\" commented [Agent Name]. \"[Academy Name] provides the perfect environment for young players to develop both on and off the pitch.\"\n\n[Player Name]'s placement includes:\n✓ Full-time professional coaching\n✓ Educational program integration\n✓ Accommodation and meals\n✓ Medical and fitness support\n✓ Pathway to senior team opportunities\n\nWe look forward to following [his/her] progress!\n\n🏫 Academy: [Academy Name]\n📍 Location: [City, Country]\n⏱️ Duration: [Contract Length]\n🎯 Age Group: [U-17, U-19, etc.]\n⚽ Position: [Position]",
  "image": "academy-[player-name].jpg",
  "category": "academy"
}
```

---

## Template 3: Player Success Story / Biography Feature

```json
{
  "id": 5,
  "title": "Player Spotlight: [Player Name] - Journey from [Origin] to [Current Achievement]",
  "date": "2025-01-25",
  "excerpt": "Meet [Player Name], whose dedication and talent have taken [him/her] from local leagues to professional trials across Europe.",
  "content": "**Early Beginnings**\n\n[Player Name], now [age], began [his/her] football journey at age [age] in [hometown/country]. Growing up in [brief background], [he/she] developed a passion for the game playing [mention early clubs or street football context].\n\n**The Breakthrough**\n\n[His/Her] talent was first noticed when [specific achievement or moment, e.g., 'scoring 15 goals in a single season for local club...' or 'being selected for the national youth team']. This caught the attention of Galaxy Sports Management scouts in [year].\n\n**Current Journey**\n\nSince joining Galaxy Sports Management, [Player Name] has:\n• Completed [number] professional trials\n• Trained with [clubs/academies]\n• Represented [national team level if applicable]\n• Developed [specific skills]\n\n**Playing Style**\n\n[Player Name] is known for [his/her] [describe playing style, e.g., 'explosive pace on the wing and ability to beat defenders one-on-one' or 'commanding presence in midfield and exceptional passing range'].\n\n**What's Next**\n\n[Player Name] is currently [current status, e.g., 'in talks with several clubs in Portugal' or 'preparing for trials in Finland']. [His/Her] ambition is to [player's goal].\n\n\"[Quote from player about their journey, dreams, or gratitude]\"\n\n📊 **Player Profile:**\n• Age: [age]\n• Position: [position]\n• Nationality: [country]\n• Height: [height]\n• Foot: [Right/Left]\n• Current Club: [club or 'Free Agent']\n• Career Highlights: [list key achievements]",
  "image": "spotlight-[player-name].jpg",
  "category": "player-story"
}
```

---

## Template 4: Multiple Trials Announcement (Batch Update)

```json
{
  "id": 6,
  "title": "5 Galaxy Players Head to European Trials This Month",
  "date": "2025-02-01",
  "excerpt": "An exciting month ahead as five of our players travel across Europe for professional trials.",
  "content": "February marks a busy period for Galaxy Sports Management as we coordinate five simultaneous trial opportunities for our talented players across Europe.\n\n**Trial Schedule:**\n\n🇫🇮 **Finland - KAPA Kajanni**\n• [Player Name 1], [Position], [Age]\n• Trial Dates: Feb 5-12\n• Focus: First team integration\n\n🇵🇹 **Portugal - [Club Name]**\n• [Player Name 2], [Position], [Age]\n• Trial Dates: Feb 8-15\n• Focus: U-23 squad assessment\n\n🇨🇾 **Cyprus - [Club Name]**\n• [Player Name 3], [Position], [Age]\n• [Player Name 4], [Position], [Age]\n• Trial Dates: Feb 10-17\n• Focus: Women's first team\n\n🇩🇪 **Germany - [Club Name]**\n• [Player Name 5], [Position], [Age]\n• Trial Dates: Feb 12-19\n• Focus: Academy placement\n\n\"This represents months of hard work from our scouting team,\" said [Agent Name]. \"We've carefully matched each player with clubs that suit their style and development needs.\"\n\nWe'll be providing updates throughout the month. Follow us on social media for live updates!",
  "image": "multi-trials-february.jpg",
  "category": "trials"
}
```

---

## Image Guidelines

### Photo Requirements:
- **Resolution:** Minimum 800x600px (higher for featured stories)
- **Format:** JPG, PNG, or WebP
- **Size:** Keep under 200KB after optimization (use TinyPNG)
- **Naming:** Use descriptive names: `trial-lucy-massaquoi.jpg`, `academy-acacia-small.jpg`

### Photo Ideas:
1. **Action shots:** Player during match/training
2. **Portrait:** Professional headshot with club/national team jersey
3. **Signing photos:** Player with contracts, team staff, or agents
4. **Training scenes:** On-field drills, gym work
5. **Celebration moments:** Goals, victories, award ceremonies

### Where to Add Images:
Save all images in `assets/images/` folder, then reference in JSON:
```json
"image": "filename.jpg"
```

---

## How to Add News to Website

### Step 1: Edit JSON File
Open `data/projects.json` and add your news item to the `news[]` array:

```json
{
  "players": [...],
  "teams": [...],
  "news": [
    {
      "id": 1,
      "title": "Existing news...",
      ...
    },
    {
      "id": 2,
      "title": "Existing news...",
      ...
    },
    {
      "id": 3,
      "title": "NEW NEWS ITEM HERE",
      "date": "2025-01-15",
      "excerpt": "Brief summary...",
      "content": "Full article text...",
      "image": "news-photo.jpg",
      "category": "trials"
    }
  ]
}
```

### Step 2: Add Image
Place image file in `assets/images/` folder

### Step 3: Create Detail Page (Optional)
For featured stories, copy `news-item-1.html` to `news-item-3.html` and customize with full content

### Step 4: Test
Open index.html or news.html in browser to see the new item

---

## Content Writing Tips

### Headlines:
✅ **Good:** "Lucy Massaquoi Secures Trial at German Second Division Club"  
❌ **Avoid:** "Good news for Lucy"

### Excerpts (Card Preview):
- Keep to 20-30 words
- Include player name, achievement, and location
- End with intrigue to encourage clicks

### Full Content:
- Start with key details (who, what, where, when)
- Add context and background
- Include quotes (from players, agents, or coaches)
- End with what's next
- Use bullet points for stats/facts
- Add emojis sparingly for visual breaks

### Tone:
- Professional but warm
- Celebrate achievements
- Show support and pride
- Factual and specific

---

## Categories to Use

Add `"category"` field to organize news:
- `"trials"` - Trial announcements
- `"academy"` - Academy placements
- `"signing"` - Contract signings
- `"player-story"` - Feature interviews/spotlights
- `"partnership"` - New club partnerships
- `"achievement"` - Awards, milestones, records

---

## Next Steps

1. Upload your WhatsApp logo image as `whatsapp logo.png` to `assets/images/`
2. Gather player photos and achievements
3. Write news content using the templates above
4. Add to `data/projects.json`
5. Test on local site before deploying

Need help with specific player stories or trial announcements? Let me know which players and I'll help draft the content!
