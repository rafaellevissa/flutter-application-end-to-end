import { test } from '@japa/runner';
import CountryCitiesService from '../../../services/CountryCitiesService';

test.group('parseCsvFile', async () => {
  const countryCitiesService = new CountryCitiesService();

  test('csv when header is empty', async ({ assert }, done) => {
    const csv = 'Brazil,Bahia,Salvador,1\nBrazil,Bahia,Feira de Santana,2';
    const header = [];

    countryCitiesService.parseCsvFile(csv, header)
      .then(() => done('csv file should not parse when header is missing'))
      .catch(error => {
        assert.equal(error, 'Invalid Record Length: columns length is 0, got 4 on line 1');
        done();
      });

  }).waitForDone();

  test('csv when header does not match the content', async ({ assert }, done) => {
    const csv = 'Brazil,Bahia,Salvador,1\nBrazil,Bahia,Feira de Santana,2';
    const header = ['country', 'city'];

    countryCitiesService.parseCsvFile(csv, header)
      .then(() => done('csv file should not parse when header is missing'))
      .catch(error => {
        assert.equal(error, 'Invalid Record Length: columns length is 2, got 4 on line 1');
        done();
      });

  }).waitForDone();

  test('csv when content is empty', async ({ assert }, done) => {
    const csv = '';
    const header = ['country', 'city', 'subcountry', 'id'];

    countryCitiesService.parseCsvFile(csv, header)
      .then(result => {
        assert.isObject(result);
        done()
      })
      .catch(error => done(error));

  }).waitForDone();

  test('csv with content and header matching', async ({ assert }, done) => {
    const csv = 'Brazil,Salvador,Bahia,1\nBrazil,São Paulo,São Paulo,1';
    const header = ['country', 'city', 'subcountry', 'id'];
    const expectedOutput = {
      'Brazil': [
        {
          country: 'Brazil',
          city: 'Salvador',
          subcountry: 'Bahia',
          id: '1'
        },
        {
          country: 'Brazil',
          city: 'São Paulo',
          subcountry: 'São Paulo',
          id: '1'
        }
      ]
    }

    countryCitiesService.parseCsvFile(csv, header)
      .then(result => {
        assert.isObject(result);
        assert.deepEqual(result, expectedOutput);
        done();
      })
      .catch(error => done(error));

  }).waitForDone();

  test('csv using a different delimiter then comma (,)', async ({ assert }, done) => {
    const csv = 'Brazil;Salvador;Bahia;1\nBrazil;São Paulo;São Paulo;1';
    const header = ['country', 'city', 'subcountry', 'id'];

    countryCitiesService.parseCsvFile(csv, header)
      .then(() => {
        done('csv file should not be parsed when using another delimiter then comma');
      })
      .catch(error => {
        assert.equal(error, 'Invalid Record Length: columns length is 4, got 1 on line 1');
        done();
      });

  }).waitForDone();
});
