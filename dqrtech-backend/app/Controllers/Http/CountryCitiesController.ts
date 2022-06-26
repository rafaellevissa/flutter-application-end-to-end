import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import type { CountryCitiesServiceInterface } from '@ioc:Dqrtech/CountryCitiesService';
import CountryCitiesService from '../../../services/CountryCitiesService'
import fs from 'fs';
import { promisify } from 'util';

const readFile = promisify(fs.readFile);

export default class CountryCitiesController {
  private countryCitiesService: CountryCitiesServiceInterface;

  constructor() {
    this.countryCitiesService = new CountryCitiesService();
  }

  public async upload({ request, response }: HttpContextContract) {
    try {
      const file = request.file('file', {
        size: '2mb',
        extnames: ['csv'],
      });

      if (!file || !file.isValid) {
        const errors = !file ? ['File is required!'] : file.errors.map(error => error.message);

        return response.status(400).json({ errors });
      }

      const csvHeader = ['name', 'country', 'subcountry', 'geonameid'];

      const fileContent = await readFile(
        file.tmpPath as fs.PathOrFileDescriptor,
        'utf-8'
      );

      const dataGroupByCountry = await this.countryCitiesService.parseCsvFile(fileContent, csvHeader);

      await this.countryCitiesService.save(dataGroupByCountry);

      return response.status(201).json(dataGroupByCountry);
    } catch (error) {
      return response.status(500).json({ error: error.message });
    }
  }

}
