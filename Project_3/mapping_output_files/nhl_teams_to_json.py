import csv
import json

def csv_to_json(csv_file, json_file):
    # Read CSV file
    with open(csv_file, 'r', encoding='utf-8-sig') as file:
        reader = csv.DictReader(file)
        data = [row for row in reader]

    # Convert certain columns to numbers
    for row in data:
        row['tmNo'] = int(row['tmNo'])
        row['year_'] = int(row['year_'])
        row['lat'] = float(row['lat'])
        row['long'] = float(row['long'])
        row['totalSeasons'] = int(row['totalSeasons'])
        row['pointPercent'] = float(row['pointPercent'])
        row['playoffSeasons'] = int(row['playoffSeasons'])
        row['playoffPercent'] = float(row['playoffPercent'])
        row['SCAppearances'] = int(row['SCAppearances'])
        row['StanleyCupWins'] = int(row['StanleyCupWins'])
        row['lastSeason'] = int(row['lastSeason'])
        row['teamChangeLat'] = float(row['teamChangeLat'])
        row['teamChangeLong'] = float(row['teamChangeLong'])

    # Write JSON file
    with open(json_file, 'w') as file:
        json.dump(data, file, indent=4)

# Example usage
csv_to_json('NHL_team_file_save.csv', 'NHL_team_locations.json')
