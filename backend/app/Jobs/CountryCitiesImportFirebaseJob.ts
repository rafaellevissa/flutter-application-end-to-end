import { JobContract } from '@ioc:Rocketseat/Bull'
import FireStoreService from '../../services/FireStoreService';
import * as yup from 'yup';



/*
|--------------------------------------------------------------------------
| Job setup
|--------------------------------------------------------------------------
|
| This is the basic setup for creating a job, but you can override
| some settings.
|
| You can get more details by looking at the bullmq documentation.
| https://docs.bullmq.io/
*/

export default class CountryCitiesImportFirebaseJob implements JobContract {
  public key = 'CountryCitiesImportFirebaseJob'

  public async handle(job) {
    const { data: { countries, items } } = job;
    const fireStoreService = new FireStoreService();

    for (let country of countries) {
      const countryDocument = await fireStoreService
        .createDocument('countries', { name: country });


      for (let item of items[country]) {
        try {
          const schema = yup.object({
            country: yup.string().required(),
            name: yup.string().required(),
            subcountry: yup.string().required(),
            geonameid: yup.string().required()
          });

          await schema.validate(item);
        } catch (error) {
          continue
        }

        await fireStoreService.createSubCollection(
          'countries',
          countryDocument.id,
          'cities',
          item
        );
      }
    }
  }
}
