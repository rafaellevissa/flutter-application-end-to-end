import { parse } from 'csv-parse';
import { CityInterface, CountryCitiesServiceInterface } from '@ioc:Dqrtech/CountryCitiesService';
import Bull from '@ioc:Rocketseat/Bull'
import Job from 'App/Jobs/CountryCitiesImportFirebaseJob'

class CountryCitiesService implements CountryCitiesServiceInterface {
  async parseCsvFile(fileContent: string, csvHeader: string[]): Promise<{ [key: string]: CityInterface[] }> {
    return new Promise((resolve, reject) => {
      parse(fileContent, {
        delimiter: ',',
        columns: csvHeader
      }, (error, result) => {
        if (error) {
          return reject(error.message);
        }

        const dataGroupByCountry = result.reduce((obj, currentValue) => ({
          ...obj,
          [currentValue.country]: obj[currentValue.country] ?
            [...obj[currentValue.country], currentValue] :
            [currentValue]
        }), {});

        delete dataGroupByCountry['country'];

        return resolve(dataGroupByCountry);
      })
    });
  }

  async save(items: any) {
    const countries = Object.keys(items || []);

    if (countries.length <= 0) {
      throw new Error('No country was provided.');
    }

    Bull.add(
      new Job().key,
      {
        countries,
        items
      }
    )
  }
}

export default CountryCitiesService;