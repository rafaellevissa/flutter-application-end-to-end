declare module '@ioc:Dqrtech/CountryCitiesService' {
  export interface CityInterface {
    name: string;
    country: string;
    subcountry: string;
    geonameid: string;
  }


  export interface CountryCitiesServiceInterface {
    save(data: any): Promise<any>;
    parseCsvFile(fileContent: string, csvHeader: string[]): Promise<{ [key: string]: CityInterface[] }>
  }
}